# nginx configuration

installation of nginx as a reverse proxy on a pve

## Index

1. [installation](#installation)
2. [configure ssl](#ssl)

\# [Find Me](#findme)  
\# [License](#license)

# 1. installation <a name="installation"></a>

```shell
apt install nginx

rm /etc/nginx/conf.d/default

```

# 2. configure ssl <a name="ssl"></a>

**generate dhparam.pem**

```shell
cd /etc/ssl/
openssl dhparam -out dhparam.pem 4096

```

**link certificates**

```shell
ln -s ~/.acme.sh/3x3cut0r.de_ecc/3x3cut0r.de.cer /etc/ssl/live/3x3cut0r.de/cert.pem
ln -s ~/.acme.sh/3x3cut0r.de_ecc/3x3cut0r.de.key /etc/ssl/live/3x3cut0r.de/privkey.pem
ln -s ~/.acme.sh/3x3cut0r.de_ecc/fullchain.cer /etc/ssl/live/3x3cut0r.de/fullchain.pem

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
