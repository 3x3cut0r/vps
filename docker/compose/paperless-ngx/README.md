# paperless-ngx

Docker Compose stack for Paperless-ngx. This README focuses on an ingest workflow where documents are dropped into a local folder, synced or mounted to the server, consumed by Paperless, and then removed from the inbox.

## Why Syncthing for consume sync

Recommended setup: use Syncthing to sync the Paperless consume folder (`/usr/src/paperless/consume`) to your devices.

Workflow:
1. You put a file into your local "scan" folder.
2. Syncthing syncs it to the server-side `paperless-consume` volume.
3. Paperless consumes the file and removes it from consume.
4. Syncthing syncs that deletion back to all clients, so the file disappears locally.

## Server/LXC setup

### 1) Add Syncthing service to this stack

Add this service to `docker-compose.yml` in this directory:

```yaml
  paperless-syncthing:
    container_name: paperless-syncthing
    image: lscr.io/linuxserver/syncthing:latest
    restart: unless-stopped
    networks:
      paperless:
        ipv4_address: "10.24.21.7"
    environment:
      PUID: "1000"
      PGID: "1000"
      TZ: "Europe/Berlin"
    volumes:
      - paperless-syncthing-config:/config
      - paperless-consume:/consume
    ports:
      - "8384:8384"   # Syncthing Web UI
      - "22000:22000/tcp"
      - "22000:22000/udp"
      - "21027:21027/udp"
    labels:
      - "wud.watch=true"
      - "wud.watch.digest=true"
      - "wud.display.name=Paperless-NGX - Syncthing"
      - "wud.trigger.include=docker.autoupdate"
      - "wud.tag.include=^latest$"
      - "wud.link.template=https://github.com/syncthing/syncthing/releases/tag/v$${major}.$${minor}.$${patch}"
```

Add this volume in the `volumes:` section:

```yaml
  paperless-syncthing-config:
    name: paperless-syncthing-config
```

Important:
- Keep `paperless-consume:/consume` exactly like shown. This is the shared ingest folder.
- `PUID`/`PGID` should match the user that should own files in the Docker volumes.

### 2) Start/recreate the stack

```bash
docker compose up -d
```

### 3) Initial Syncthing hardening

1. Open `http://<LXC-IP>:8384`.
2. Set GUI username/password in Syncthing settings.
3. Prefer access through VPN/Tailscale/reverse proxy ACL instead of exposing 8384 to the public internet.
4. In folder settings, use `Send & Receive` (default) and keep "Ignore Deletes" disabled.

### 4) Share the consume folder

1. In Syncthing, ensure folder path is `/consume`.
2. Folder ID example: `paperless-consume`.
3. Add your laptop/macOS/windows devices.
4. On each client, accept the shared folder and map it to a local path of your choice.

## Client setup by platform

All Syncthing clients follow the same concept:
- Install Syncthing.
- Pair device with the server device ID.
- Accept remote folder `paperless-consume`.
- Choose a local folder like `~/Paperless-Inbox`.

### macOS

1. Install Syncthing (for example via Homebrew):
   ```bash
   brew install syncthing
   brew services start syncthing
   ```
2. Open local GUI (`http://127.0.0.1:8384`) and add server device.
3. Accept shared folder and set local path, e.g. `/Users/<user>/Paperless-Inbox`.
4. Configure scanner app/automation to drop PDFs into that folder.

### Linux

1. Install Syncthing from your distro packages.
2. Start and enable user service:
   ```bash
   systemctl --user enable --now syncthing.service
   ```
3. Open local GUI, add server device, accept `paperless-consume`.
4. Use local path, e.g. `/home/<user>/Paperless-Inbox`.

## Fallback: SSHFS mount for macOS and Linux

If Syncthing is blocked by restrictive networks, the pragmatic fallback is an SSHFS mount. This is not sync. Instead, you mount the remote consume folder locally and drop files directly into it.

Workflow:
1. You mount the remote consume folder via SSH.
2. You save a document into the mounted local folder.
3. Paperless consumes the file on the server.
4. The file disappears from the mounted folder because it was removed on the server.

### What to do on the LXC

Use the LXC's own SSH server. Do not add a separate SSH/SFTP container for this fallback.

#### 1) Install and enable SSH

```bash
apt update
apt install -y openssh-server acl
systemctl enable --now ssh
```

#### 2) Create a dedicated SSHFS user

Create a dedicated user named `paperless-consumer` with UID `1001`:

```bash
useradd -m -u 1001 -s /bin/bash paperless-consumer
```

#### 3) Find the real Docker volume path

Find the mountpoint of the `paperless-consume` Docker volume:

```bash
docker volume inspect paperless-consume
```

Look for the `Mountpoint` value. On a standard Docker setup this is usually similar to:

```text
/var/lib/docker/volumes/paperless-consume/_data
```

#### 4) Create a stable path for SSHFS

Bind the Docker volume to a stable path that you can safely expose via SSHFS:

```bash
mkdir -p /srv/paperless-consume
mount --bind /var/lib/docker/volumes/paperless-consume/_data /srv/paperless-consume
```

Make the bind mount persistent in `/etc/fstab`:

```fstab
/var/lib/docker/volumes/paperless-consume/_data /srv/paperless-consume none bind 0 0
```

#### 5) Grant the SSHFS user access

Your Docker/Paperless setup uses UID `1000`. The SSHFS user uses UID `1001`. Do not change ownership of the consume directory. Instead, grant access via ACLs:

```bash
setfacl -m u:paperless-consumer:rwx /srv/paperless-consume
setfacl -d -m u:paperless-consumer:rwx /srv/paperless-consume
```

This keeps Paperless ownership intact while allowing the SSHFS user to upload files.

#### 6) Configure SSH key authentication

Create the SSH directory and install your public key:

```bash
mkdir -p /home/paperless-consumer/.ssh
chmod 700 /home/paperless-consumer/.ssh
touch /home/paperless-consumer/.ssh/authorized_keys
chmod 600 /home/paperless-consumer/.ssh/authorized_keys
chown -R paperless-consumer:paperless-consumer /home/paperless-consumer/.ssh
```

Append your public key to:

```text
/home/paperless-consumer/.ssh/authorized_keys
```

#### 7) Harden SSH for this user

Recommended settings in `/etc/ssh/sshd_config`:

```text
PubkeyAuthentication yes
PasswordAuthentication no
AllowUsers paperless-consumer
```

Then reload SSH:

```bash
systemctl reload ssh
```

#### 8) Test SSH before using SSHFS

From your client, confirm this works before mounting:

```bash
ssh paperless-consumer@<server>
```

#### 9) Network exposure recommendation

- Expose only SSH (`22/tcp`) for this fallback path.
- Prefer access through VPN/Tailscale if possible.
- If you expose SSH publicly, use key-only auth and fail2ban or equivalent protection.

### macOS fallback with SSHFS

1. Install macFUSE.
2. Install SSHFS for macOS.
3. Create a local mountpoint:
   ```bash
   mkdir -p ~/Paperless-Inbox
   ```
4. Mount the remote consume folder:
   ```bash
   sshfs paperless-consumer@<server>:/srv/paperless-consume ~/Paperless-Inbox
   ```
5. Save documents into `~/Paperless-Inbox`.

Unmount:

```bash
umount ~/Paperless-Inbox
```

### Linux fallback with SSHFS

1. Install `sshfs` from your distro packages.
2. Create a local mountpoint:
   ```bash
   mkdir -p ~/Paperless-Inbox
   ```
3. Mount the remote consume folder:
   ```bash
   sshfs paperless-consumer@<server>:/srv/paperless-consume ~/Paperless-Inbox
   ```
4. Save documents into `~/Paperless-Inbox`.

Unmount:

```bash
fusermount -u ~/Paperless-Inbox
```

Notes:
- SSHFS is convenient, but less robust than Syncthing on unstable networks.
- If the mount drops, applications may show I/O errors until you remount it.
- For this fallback, point scanner apps directly at the mounted folder.

## Verification

1. Put `test.pdf` into your local inbox folder or SSHFS-mounted folder.
2. Wait for sync or upload to server.
3. Check Paperless UI for new document.
4. After consumption, verify `test.pdf` disappears from the inbox location.

## Troubleshooting

- File does not disappear locally:
  - Check Syncthing folder setting "Ignore Deletes" is disabled.
  - Check client folder type is not `Receive Only`.
- File never arrives in Paperless:
  - Check server Syncthing folder path is `/consume`.
  - Check `paperless` container has `paperless-consume:/usr/src/paperless/consume`.
- Permission problems:
  - Align Syncthing `PUID`/`PGID` with volume file ownership.
  - Recreate Syncthing container after changing UID/GID.
- Conflicts (`sync-conflict` files):
  - Usually from editing same file on multiple clients; avoid modifying files in inbox after drop.
- SSHFS mount fails:
  - Verify SSH login works first with `ssh paperless-consumer@<server>`.
  - Verify `/srv/paperless-consume` is a working bind mount.
  - Verify ACLs are present with `getfacl /srv/paperless-consume`.
  - Check that the Docker volume path in `/etc/fstab` still matches `docker volume inspect paperless-consume`.

## Usage

Paperless frontend:
- `https://paperless.3x3cut0r.de`

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) This project is licensed under the GNU General Public License.
