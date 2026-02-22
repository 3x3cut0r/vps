# rustdesk

**docker-compose.yml for rustdesk-server - a self-hosted remote desktop server for RustDesk, an open-source TeamViewer alternative**

## Index

1. [prerequisites](#prerequisites)
2. [configuration](#configuration)
3. [deploy docker-compose.yml](#deploy)
4. [usage](#usage)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**Open ports on your firewall:**
- Port 21115/tcp - NAT type test
- Port 21116/tcp - TCP hole punching / registration / heartbeat
- Port 21116/udp - ID registration / heartbeat
- Port 21117/tcp - Relay services

**For ufw:**
```shell
ufw allow 21115/tcp
ufw allow 21116/tcp
ufw allow 21116/udp
ufw allow 21117/tcp
```

# 2. configuration <a name="configuration"></a>

**No required environment variables** - RustDesk server runs with default configuration.

**To configure clients:**
- Set ID server: `rustdesk.3x3cut0r.de`
- Set Relay server: `rustdesk-relay.3x3cut0r.de`

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/rustdesk/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/rustdesk/docker-compose.yml)**

# 4. usage <a name="usage"></a>

**Connect from RustDesk client:**
1. Download RustDesk client from https://rustdesk.com
2. Set ID/Relay server to `rustdesk.3x3cut0r.de`
3. Connect to remote machines

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
