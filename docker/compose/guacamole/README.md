# guacamole

**docker-compose.yml for guacamole - a clientless remote desktop gateway supporting VNC, RDP, and SSH**

## Index

1. [prerequisites](#prerequisites)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)  
   3.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**1. Create MariaDB user and database for Guacamole using phpMyAdmin**

**2. Download and extract [guacamole-auth-jdbc-1.5.3.tar.gz](https://guacamole.apache.org/releases/1.5.3/)**

**3. Import schema into your Guacamole database:**
- `guacamole-auth-jdbc-1.5.3/mysql/schema/001-create-schema.sql`
- `guacamole-auth-jdbc-1.5.3/mysql/schema/002-create-admin-user.sql`

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/guacamole/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/guacamole/docker-compose.yml)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**Frontend**  
[https://guacamole.3x3cut0r.de/guacamole](https://guacamole.3x3cut0r.de/guacamole)

**Backend**  
[https://guacamole.3x3cut0r.de/guacamole/#/settings](https://guacamole.3x3cut0r.de/guacamole/#/settings)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
