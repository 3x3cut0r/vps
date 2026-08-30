# coturn

**docker-compose.yml for coturn - a free open source implementation of TURN and STUN server for VoIP and WebRTC**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Runtime configuration:**

The active CoTURN configuration is defined in `docker-compose.yml` via the `command` array.

Required environment variables:

```shell
POSTGRES_PASSWORD=<postgres-password>
REDIS_PASSWORD=<redis-password>
TURN_SECRET=<turn-shared-secret>
TURN_API_KEY=<nextcloud-turn-api-key>
HASH_KEY=<signaling-hash-key>
BLOCK_KEY=<signaling-block-key>
INTERNAL_SHARED_SECRET_KEY=<signaling-internal-shared-secret>
BACKEND_1_SHARED_SECRET=<nextcloud-signaling-shared-secret>
NATS_PASSWORD=<nats-password>
GEOIP_LICENSE=<maxmind-license-key>
```

**Open ports on your firewall:**
- Port 3468/tcp - STUN/TURN
- Port 3468/udp - STUN/TURN
- Port 5349/tcp - TURN TLS
- Port 5349/udp - TURN DTLS
- Port 49160-49299/udp - Relay ports

**Administrative and internal ports:**
- Port 2214/tcp - CoTURN web admin
- Port 8081/tcp - Nextcloud Spreed Signaling
- Port 8188/tcp - Janus WebSocket API
- Port 4222/tcp - NATS

**Network notes:**
- This stack is designed for `network_mode: host` inside the coturn LXC.
- WAN forwarding on the Proxmox host must match the active CoTURN ports (`3468`, `5349`, `49160-49299`).
- Public IPv4 access to the CoTURN web admin requires a separate DNAT rule for `2214/tcp` to the coturn LXC.
- Internal DNS should resolve `turn.3x3cut0r.de` to the coturn LXC IP for local clients.
- TURN relay candidates still use the public IP from `--external-ip`, so LAN clients may still require hairpin NAT.
- The Janus WebSocket connection used by `nextcloud-spreed-signaling` does not use Janus `apisecret` or `token-auth`; do not enable those options unless you switch to a client that supports them.
- Janus reads its mounted config files from `/opt/docker/config-files/janus/janus.jcfg` and `/opt/docker/config-files/janus/janus.eventhandler.wsevh.jcfg`.

### Web-admin database user

The coturn web admin authenticates against the `admin_user` table in the
PostgreSQL user database. Authentication configured in Nginx Proxy Manager is
separate from this account. The SQLite `turndb` is inactive in this stack.

Verify that the table exists:

```shell
docker exec coturn-postgres \
  psql -U coturn -d coturn -c '\d admin_user'
```

Create the realm-restricted user `admin`:

```shell
docker exec coturn turnadmin -A \
  --psql-userdb="postgresql://coturn:<postgres-password>@127.0.0.1:5432/coturn" \
  -u admin \
  -r turn.3x3cut0r.de \
  -p '<admin-password>'
```

`<postgres-password>` is the existing PostgreSQL password. `<admin-password>`
is the new plaintext password for the coturn web admin. `turnadmin` hashes the
admin password automatically before storing it.

Verify the account:

```shell
docker exec coturn-postgres \
  psql -U coturn -d coturn \
  -c 'SELECT name, realm FROM admin_user;'
```

Never commit real passwords or replace the placeholders in this README.

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/coturn/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/coturn/docker-compose.yml)**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
