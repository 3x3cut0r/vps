# mailcow inside LXC

**howto install mailcow inside LXC**

## Index

1. [prerequisites](#prerequisites)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)  
   3.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>
**on proxmox host**  
```shell
apt install cgroupfs-mount

```

**LXC Container System Requirements: unpriviledged=1, nesting=1, keyctl=1, 6GB RAM, 2CPU, 64GB HDD**  

**on LXC**  
```shell
apt purge postfix

```

# 2. deploy docker-compose.yml <a name="prerequisites"></a>

**[see docker/compose/mailcow/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/mailcow/docker-compose.yml)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**Frontend**  
[https://skel.3x3cut0r.de](https://skel.3x3cut0r.de)

**Backend**  
[https://skel.3x3cut0r.de/admin](https://skel.3x3cut0r.de/admin)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
