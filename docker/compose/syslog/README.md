# syslog-ng

# 1. deploy docker-compose.yml

# 2. change docker logging driver
**for a single container with docker-compose:**  
```shell
services:
    some-service:
        ...
        logging:
            driver: "syslog"
            options:
                syslog-address: "udp://syslog-ng:514"
...
networks:
    ...
    syslog-ng:
        external:
            name: syslog-ng

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
