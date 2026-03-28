# paperless-ngx

Docker Compose stack for Paperless-ngx. This README focuses on a cross-platform ingest workflow where documents are dropped into a local folder (macOS, Linux, Windows), synced to the server, consumed by Paperless, and then removed from all clients.

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

All clients follow the same concept:
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

### Windows

1. Install Syncthing (community build or Syncthingtray).
2. Start Syncthing and open GUI (`http://127.0.0.1:8384`).
3. Add server device and accept folder.
4. Use local path, e.g. `C:\Users\<user>\Paperless-Inbox`.
5. Configure your scanner software to save into this folder.

## Verification

1. Put `test.pdf` into your local inbox folder.
2. Wait for sync to server.
3. Check Paperless UI for new document.
4. After consumption, verify `test.pdf` disappears from local inbox on all devices.

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

## Usage

Paperless frontend:
- `https://paperless.3x3cut0r.de`

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) This project is licensed under the GNU General Public License.
