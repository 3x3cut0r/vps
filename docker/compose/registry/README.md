# docker-registry

**docker-compose.yml for your own docker-registry**  

## Index

1. [reverse-proxy / nginx configuration](#reverse-proxy)  
2. [deploy docker-compose.yml](#deploy)  
3. [usage](#usage)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**1.1 deploy docker-registry.conf**  
**[see nginx/conf.d/docker-registry.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/docker-registry.conf)**  

**1.2 edit nginx/nginx.conf**  
```shell
...
    upstream registry   { server 127.0.0.1:4155; }

    ## Set a variable to help us decide if we need to add the
    ## 'Docker-Distribution-Api-Version' header.
    ## The registry always sets this header.
    ## In the case of nginx performing auth, the header is unset
    ## since nginx is auth-ing before proxying.
    map $upstream_http_docker_distribution_api_version $docker_distribution_api_version {
      '' 'registry/2.0';
    }

```

**1.3 create htpasswd string with bcrypt on [https://hostingcanada.org/htpasswd-generator/](https://hostingcanada.org/htpasswd-generator/)**  
**1.4 create file /etc/nginx/conf.d/docker-registry.htpasswd and paste your bcrypt string**  
```shell
3x3cut0r:$2y$10$V12ZCnJFgK/wwL22BvTN7uKcbTh0BkucMq8SsCmm4AKYuqXTNjjkO

```

# 2. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/docker-registry/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/docker-registry/docker-compose.yml)**  

# 3. usage <a name="usage"></a>  
**login**  
```shell
docker login registry.3x3cut0r.de

```
**push**  
```shell
docker image push registry.3x3cut0r.de/3x3cut0r/alpine:latest

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
