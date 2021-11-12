# docker-registry

**docker-compose.yml for docker-registry - docker-registry is a ...**  

## Index

1. [deploy / docker-compose.yml](#deploy)  
2. [reverse-proxy / nginx configuration](#reverse-proxy)  
3. [usage](#usage)  
  3.1 [browse](#browse)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. deploy / docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/docker-registry/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/docker-registry/docker-compose.yml)**  

# 2. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/docker-registry.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/docker-registry.conf)**  
**edit nginx/nginx.conf**  
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

# 3. usage <a name="usage"></a>  

### 3.1 browse <a name="browse"></a>  
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
