# syslog-ng

**docker-compose.yml for syslog-ng - a syslog daemon for centralized logging**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Connect containers to syslog-ng network:**
```yaml
networks:
  syslog-ng:
    external:
      name: syslog-ng
```

**Configure Docker logging driver for a container:**
```yaml
services:
  some-service:
    logging:
      driver: "syslog"
      options:
        syslog-address: "udp://syslog-ng:514"
networks:
  syslog-ng:
    external:
      name: syslog-ng
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/syslog/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/syslog/docker-compose.yml)**

# 3. usage <a name="usage"></a>

**View logs:**
```shell
docker container logs syslog-ng
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
