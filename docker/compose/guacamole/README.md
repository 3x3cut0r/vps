# guacamole

**docker-compose.yml for guacamole - guacamole is a ...**  

## Index

1. [prepare mariadb](#mariadb)  
2. [deploy docker-compose.yml](#deploy)  
3. [reverse-proxy / nginx configuration](#reverse-proxy)  
4. [usage](#usage)  
  4.1 [browse](#browse)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. prepare mariadb <a name="mariadb"></a>  
**1. create mariadb user and database for guacamole using phpmyadmin**  
**2. download and extract [guacamole-auth-jdbc-1.4.0.tar.gz](https://guacamole.apache.org/releases/1.4.0/)**  
**3. import guacamole-auth-jdbc-1.4.0/mysql/schema/001-create-schema.sql into your new created guacamole database using phpmyadmin**  
**4. import guacamole-auth-jdbc-1.4.0/mysql/schema/002-create-admin-user.sql into your new created guacamole database using phpmyadmin**  

# 2. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/guacamole/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/guacamole/docker-compose.yml)**  

# 3. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/guacamole.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/guacamole.conf)**  

# 4. usage <a name="usage"></a>  

### 4.1 browse <a name="browse"></a>  
**Frontend**  
[https://guacamole.3x3cut0r.de/guacamole/#/settings](https://guacamole.3x3cut0r.de/guacamole/#/settings)  

**Backend**  
[https://guacamole.3x3cut0r.de/guacamole/#/settings/sessions](https://guacamole.3x3cut0r.de/guacamole/#/settings/sessions)  

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
