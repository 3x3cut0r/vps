# mailcow

**docker-compose.yml for mailcow - mailcow is a ...**  

## Index

1. [deploy docker-compose.yml](#deploy)  
2. [reverse-proxy / nginx configuration](#reverse-proxy)  
3. [configuration](#configuration)  
  3.1 [config-file](#config-file)  
4. [usage](#usage)  
  4.1 [browse](#browse)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/mailcow/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/mailcow/docker-compose.yml)**  
**on your docker-compose.yml at service mailcow-ofelia, mailcow-ipv6nat**  
**change docker.sock path:**  
```shell
...
volumes:
    - /run/user/2000/docker.sock:/var/run/docker.sock:ro
...

```

# 2. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/mailcow.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/mailcow.conf)**  

# 3. configuration <a name="configuration"></a>  

### 3.1 config-file <a name="config-file"></a>  
**download and create mailcow config-files**  
```shell
mkdir -p /home/docker/config-files
cd /home/docker/config-files
git clone https://github.com/mailcow/mailcow-dockerized
mv mailcow-dockerized mailcow
cd mailcow
./generate_config.sh

```

# 4. usage <a name="usage"></a>  

### 4.1 browse <a name="browse"></a>  
**Frontend**  
[https://mailcow.3x3cut0r.de](https://mailcow.3x3cut0r.de)  

**Backend**  
[https://mailcow.3x3cut0r.de/admin](https://mailcow.3x3cut0r.de/admin)  

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
