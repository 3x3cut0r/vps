# bigbluebutton

## Index

1. [prerequisites](#prerequisites)
2. [installation](#installation)
3. [reverse-proxy / nginx configuration](#reverse-proxy)
4. [configuration](#configuration)  
   4.1 [config-file](#config-file)
5. [usage](#usage)  
   5.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**1.1 install on LXC Container**
**System Requirements: unpriviledged=1, nesting=1, keyctl=1, 8GB RAM, 4CPU, 64GB HDD**

**1.2 enter public ip to LXC Container (without GW!)**  
/etc/network/interfaces

```shell
...
iface eth0 inet static
        address 192.168.x.x/24
        gateway 192.168.x.x
        post-up ip addr add 202.x.x.x/32 dev eth0
...
```

# 2. installation <a name="installation"></a>

**follow instructions here: [https://github.com/bigbluebutton/docker](https://github.com/bigbluebutton/docker)**

# 3. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>

**[see nginx/conf.d/bigbluebutton.conf](https://github.com/3x3cut0r/proxmox/blob/main/nginx/conf.d/bigbluebutton.conf)**

# 4. configuration <a name="configuration"></a>

**4.1 login and change password!**

**4.2 [configure greenlight](https://docs.bigbluebutton.org/greenlight/gl-install.html#3-configure-greenlight)**

# 5. usage <a name="usage"></a>

### 5.1 browse <a name="browse"></a>

**Frontend**  
[https://bigbluebutton.3x3cut0r.de](https://bigbluebutton.3x3cut0r.de)

**Backend**  
[https://bigbluebutton.3x3cut0r.de/admin](https://bigbluebutton.3x3cut0r.de/admin)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
