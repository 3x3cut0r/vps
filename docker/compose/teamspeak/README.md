# teamspeak

**docker-compose.yml for teamspeak - a proprietary voice-over-Internet Protocol (VoIP) software for audio communication**

## Index

1. [prerequisites](#prerequisites)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**Open ports on your firewall:**
- Port 9987/udp - Default voice port
- Port 10011 - ServerQuery
- Port 30033 - File transfer

**For ufw:**
```shell
ufw allow 9987/udp
ufw allow 10011
ufw allow 30033
```

**Or use ufw app TeamSpeak:**
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

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/teamspeak/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/teamspeak/docker-compose.yml)**

# 3. usage <a name="usage"></a>

**Connect from TeamSpeak client:**
1. Download TeamSpeak client from https://www.teamspeak.com
2. Connect to `teamspeak.3x3cut0r.de`
3. Use serveradmin token from logs for first login

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
