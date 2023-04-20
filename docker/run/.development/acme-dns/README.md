# acme-dns

get letsencrypt wildcard certificate for nginx using acme-dns

## Index

1. [prerequisites](#prerequisites)
2. [configure a CNAME-record in your public-dns](#cname-record)  
3. [create volumes for certbot](#volumes)  
4. [generate a certificate with certbot](#generate)  

5. [schedule renewal with a systemd-timer](#renewal)  
6. [use certificates in your /etc/nginx/conf.d/default.conf](#default.conf)
7. [test](#test)

\# [Find Me](#findme)  
\# [License](#license)  

# 1. prerequisites <a name="prerequisites"></a>
* you have a public domain (e.g.: 3x3cut0r.de)
* you can create a CNAME-record in your public dns-server

# 2. create volumes and download config for acme-dns <a name="volumes"></a>
```shell
mkdir -p /home/docker/config-files/acme-dns/config
mkdir -p /home/docker/config-files/acme-dns/data
cd /home/docker/config-files/acme-dns/config
wget ...

```

# 3. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/acme-dns/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/acme-dns/docker-compose.yml)**  

# 4. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/auth.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/auth.conf)**  


# 5. register domain and get credentials <a name="register"></a>
```shell
apt install curl python3
curl -s -X POST https://auth.3x3cut0r.de/register | python3 -m json.tool

```

**example output:**  
```shell
{
    "username": "2d999da0-346a-12ab-9aab-33fa4ff0f63a",
    "password": "Av10nBz0WRIgCmsBHgkZXxN3e1mGae9jmECHxMvC",
    "fulldomain": "1bbb06c3-28c6-4475-bd3a-656a6527a790.auth.3x3cut0r.de",
    "subdomain": "1bbb06c3-28c6-4475-bd3a-656a6527a790",
    "allowfrom": []
}

```

# 5. disable registration <a name="register"></a>
**/home/docker/config-files/acme-dns/config/config.cfg**  
```shell
...
# disable registration endpoint
disable_registration = true
...

```
**restart your acme-dns docker container**  

# 6. configure a CNAME-record in your public-dns <a name="cname-record"></a>
```shell
A NS record is mandatory for your domain!

Please deploy a DNS CNAME record under the name
_acme-challenge.3x3cut0r.de which points to 1bbb06c3-28c6-4475-bd3a-656a6527a790.auth.3x3cut0r.de

```

# 7. test <a name="test"></a>
```shell
curl -X POST https://auth.3x3cut0r.de/update \
-H "X-Api-User: 2d236da0-346a-42ad-9aab-33fa4dd0f63a" \
-H "X-Api-Key: Av90nBz0WRIgCmPBHgkZXxNAe1mGae9jnECHXMvC" \
--data '{"subdomain": "1baa06c3-21c6-4175-bd3a-65696527a780", "txt": "__validation_token_received_from_le__"}'

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
