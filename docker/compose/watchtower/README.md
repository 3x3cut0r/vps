# watchtower

**docker-compose.yml for watchtower - watchtower update your docker containers**

## Index

1. [deploy docker-compose.yml](#deploy)
2. [configuration](#reverse-proxy)
3. [prevent containers from being updated](#prevent_container_update)

\# [Find Me](#findme)  
\# [License](#license)

# 1. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/watchtower/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/watchtower/docker-compose.yml)**

# 2. configuration <a name="configuration"></a>

**set time for update in your docker-compose.yml in cron format**

```shell
...
command: --cleanup --rolling-restart --schedule "0 0 4 * * *"
...

```

# 3. prevent containers from being updated <a name="prevent_container_update"></a>

**add the following label to docker-compose.yml**

```shell
...
    labels:
        - "com.centurylinklabs.watchtower.enable=false"
...

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
