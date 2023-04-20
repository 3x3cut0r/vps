# webtop

**docker-compose.yml for webtop**  

## Index

1. [deploy docker-compose.yml](#deploy)  
2. [reverse-proxy / nginx configuration](#reverse-proxy)  
3. [configuration](#configuration)  
  3.1 [change default password of abc user](#change_password-file)  
4. [usage](#usage)  
  4.1 [browse](#browse)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/webtop/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/webtop/docker-compose.yml)**  

# 2. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/webtop.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/webtop.conf)**  

# 3. configuration <a name="configuration"></a>  

### 3.1 change default password of abc user <a name="change_password"></a>  
**on your docker host, enter:**  
```shell
docker container exec -it webtop passwd abc

```

# 4. usage <a name="usage"></a>  

### 4.1 browse <a name="browse"></a>  
**Frontend**  
[https://webtop.3x3cut0r.de](https://webtop.3x3cut0r.de)  

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
