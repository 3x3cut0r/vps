# pihole

**docker-compose.yml for pihole - a DNS sinkhole that protects your devices from unwanted content and tracks with unbound DNS resolver**

## Index

1. [download pihole-updatelists.conf](#download)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)  
   3.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. download pihole-updatelists.conf <a name="download"></a>

**Create config-folder and download pihole-updatelists.conf:**
```shell
mkdir -p /home/docker/config-files/pihole/pihole-updatelists
cd /home/docker/config-files/pihole/pihole-updatelists
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/pihole/pihole-updatelists.conf
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/pihole/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/pihole/docker-compose.yml)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**Frontend**  
[https://pihole.3x3cut0r.de](https://pihole.3x3cut0r.de)

**Admin**  
[https://pihole.3x3cut0r.de/admin](https://pihole.3x3cut0r.de/admin)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
