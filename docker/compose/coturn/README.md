# coturn

**docker-compose.yml for coturn**  

## Index

1. [deploy docker-compose.yml](#deploy)  
2. [reverse-proxy / nginx configuration](#reverse-proxy)  
3. [configuration](#configuration)  

\# [Find Me](#findme)  
\# [License](#license) 

# 1. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/coturn/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/coturn/docker-compose.yml)**  

# 2. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/coturn.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/coturn.conf)**  

# 3. configuration <a name="configuration"></a>  
**copy [docker/docker-compose/coturn/turnserver.conf](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/coturn/turnserver.conf) to /home/docker/config-files/coturn/turnserver.conf**  
**enter at least: **  
```shell
...
static-auth-secret=<static-auth-secret>
...
realm=3x3cut0r.de
...

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
