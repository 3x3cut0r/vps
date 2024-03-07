# wireguard

**docker-compose.yml for wireguard - wireguard is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography**

## Index

1. [install wireguard](#install)
2. [deploy docker-compose.yml](#deploy)
3. [reverse-proxy / nginx configuration](#reverse-proxy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. install wireguard <a name="install"></a>

```bash
apt update && apt upgrade -y
wget git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh
mkdir -p /opt/wireguard/db
```

```
cd /etc/systemd/system/
cat << EOF > wgui.service
[Unit]
Description=Restart WireGuard
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/systemctl restart wg-quick@wg0.service

[Install]
RequiredBy=wgui.path
EOF

```

```
cd /etc/systemd/system/
cat << EOF > wgui.path
[Unit]
Description=Watch /etc/wireguard/wg0.conf for changes

[Path]
PathModified=/etc/wireguard/wg0.conf

[Install]
WantedBy=multi-user.target
EOF
```

```
systemctl daemon-reload
systemctl enable wgui.{path,service}
systemctl start wgui.{path,service}
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/docker-compose/wireguard/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/wireguard/docker-compose.yml)**

# 3. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>

**[see nginx/conf.d/wireguard.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/wireguard.conf)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Backend**  
[https://wireguard-ui.3x3cut0r.de](https://wireguard-ui.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
