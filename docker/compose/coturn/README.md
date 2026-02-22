# coturn

**docker-compose.yml for coturn - a free open source implementation of TURN and STUN server for VoIP and WebRTC**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Copy turnserver.conf:**

Copy [docker/compose/coturn/turnserver.conf](https://github.com/3x3cut0r/vps/blob/main/docker/compose/coturn/turnserver.conf) to `/home/docker/config-files/coturn/turnserver.conf`

**Enter at least:**
```shell
...
static-auth-secret=<static-auth-secret>
...
realm=3x3cut0r.de
...
```

**Open ports on your firewall:**
- Port 3478/udp - STUN/TURN
- Port 5349/tcp - TURN TLS
- Port 49152-65535/udp - Relay ports

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/coturn/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/coturn/docker-compose.yml)**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
