# librechat

**docker-compose.yml for librechat**

## Index

1. [install librechat](#install)
2. [run docker-compose.yml](#deploy)
3. [reverse-proxy / nginx configuration](#reverse-proxy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. install librechat <a name="install"></a>

```bash
apt install git
mkdir -p /opt/docker/config-files
cd /opt/docker/config-files
git clone https://github.com/danny-avila/LibreChat.git
chown -R 1000:1000 LibreChat
cd LibreChat
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/librechat/.env
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/librechat/docker-compose.override.yml
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/librechat/librechat.yaml
```

**overwrite all API keys, ENV and stuff in the 3 files downloaded above!**

# 2. run docker-compose.yml <a name="deploy"></a>

```bash
docker compose up -d
```

# 3. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>

**configure librechat.3x3cut0r.de on nginx-proxy-manager**
**visit [librachat documentation](https://docs.librechat.ai/install/configuration/custom_config.html) to enable / add more endpoints**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://librechat.3x3cut0r.de](https://librechat.3x3cut0r.de)

**Register on first login!**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
