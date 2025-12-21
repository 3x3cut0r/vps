# TeamSpeak

# 1. deploy docker-compose.yml

# 2. open ports on your firewall
**Port 9987/udp default port**  
**Port 10011 for serverquerys**  
**Port 30033 to allow filetransfer**  

**for ufw:**
```shell
ufw allow 9987/udp
ufw allow 10011
ufw allow 30033

```

**OR: use ufw app TeamSpeak: (copy from repo)**
[/etc/ufw/applications.d/docker-teamspeak](https://raw.githubusercontent.com/3x3cut0r/vps/main/ufw/applications.d/docker-teamspeak)
```shell
[TeamSpeak]
title=TeamSpeak 3 Server
description=TeamSpeak 3 Server (with voice, serverquery and filetransfer)
ports=9987/udp|10011|30033

```
```shell
ufw allow 'TeamSpeak'

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
