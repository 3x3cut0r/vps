# bigbluebutton

**docker-compose.yml for bigbluebutton - an open-source web conferencing system for online learning**

## Index

1. [prerequisites](#prerequisites)
2. [installation](#installation)
3. [configuration](#configuration)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**Install on LXC Container:**
- System Requirements: unprivileged=1, nesting=1, keyctl=1
- 8GB RAM, 4CPU, 64GB HDD

**Enter public IP to LXC Container (without GW!):**

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

**Follow instructions here: [https://github.com/bigbluebutton/docker](https://github.com/bigbluebutton/docker)**

# 3. configuration <a name="configuration"></a>

**1. Login and change password!**

**2. [Configure Greenlight](https://docs.bigbluebutton.org/greenlight/gl-install.html#3-configure-greenlight)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

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
