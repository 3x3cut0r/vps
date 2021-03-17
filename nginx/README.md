# nginx

nginx as reverse proxy for docker containers

## Index

1. [install nginx](#installation)  
2. [configure nginx](#configure)  
3. [configure subdomains / reverse proxy sites](#reverse_proxy)  
4. [restart nginx](#restart)  
5. [configure firewall](#firewall)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. install nginx <a name="installation"></a>
```shell
apt install nginx
systemctl enable nginx

```

# 2. configure nginx <a name="configure"></a>
**remove default site:**  
```shell
rm /etc/nginx/sites-enabled/default
mv /var/www/html/index.nginx-debian.html /var/www/html/index.html

```
**redirect all traffic from http to https:**  
/etc/nginx/conf.d/default.conf  
```shell
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name *.3x3cut0r.de;

    # Enforce HTTPS
    return 301 https://$host$request_uri;
}

```
**create ssl.conf (copy from repo)**  
```shell
vi /etc/nginx/conf.d/ssl.conf

```
**see [docke_run/certbox](https://github.com/3x3cut0r/vps/tree/main/docker/docker_run/certbot) howto create a lets encrypt wildcard certificate**  
```shell
ln -s /home/docker/.local/share/docker/volumes/certbot-letsencrypt/_data/ /etc/nginx/ssl

```

# 3. configure subdomains / reverse proxy sites <a name="reverse_proxy"></a>
**e.g.: configure upstream server in /etc/nginx.conf (copy from repo)**  
```shell
    # List of application servers
    upstream portainer  { server 127.0.0.1:2101; }

```
**e.g.: create portainer.conf (copy from repo)**  
```shell
vi /etc/nginx/conf.d/portainer.conf

```

# 4. restart nginx <a name="restart"></a>
```shell
systemctl restart nginx

```

# 5. configure firewall <a name="firewall"></a>
```shell
ufw allow 'Nginx HTTP'
ufw allow 'Nginx HTTPS'

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
