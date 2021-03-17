# QuakeJS

# 1. deploy docker-compose.yml

# 2. open ports on your firewall
**Port 3333 for http**  
**Port 27960 for serverquery**  

**for ufw:**
```shell
ufw allow 3333
ufw allow 27960

```

**OR: use ufw app QuakeJS: (copy from repo)**
[/etc/ufw/applications.d/docker-quakejs](https://raw.githubusercontent.com/3x3cut0r/vps/main/ufw/applications.d/docker-quakejs)
```shell
[QuakeJS]
title=QuakeJS
description=QuakeJS - a port of ioquake3 to JavaScript (with http and serverquery)
ports=3333|27960

```
```shell
ufw allow 'QuakeJS'

```

**Note:**  
**quakejs cannot handle redirected https traffic. this means it cannot**  
**be operated behind a reverse proxy!**  

# 3. browse http://3x3cut0r.de:3333 and start fragging!

# 4. reduce texture detail for better performance

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
