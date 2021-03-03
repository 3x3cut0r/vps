# certbot

get letsencrypt wildcard certificate for nginx using certbot

## Index

1. [prerequisites](#prerequisites)
2. [create volumes for certbot](#volumes)  
3. [generate a certificate with certbot](#generate)  
4. [configure two TXT-records in your public-dns](#txt-records)  
5. [schedule renewal with a systemd-timer](#renewal)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. prerequisites <a name="prerequisites"></a>
* you have a public domain (e.g.: 3x3cut0r.de)
* you can create a TXT-record in your public domains dns-server

# 2. create volumes for certbot <a name="volumes"></a>
```shell
docker volume create -d local --name certbot-letsencrypt
docker volume create -d local --name certbot-logs

```

# 3. generate a certificate with certbot. <a name="generate"></a>
```shell
docker container run --rm -it \
    -v certbot-letsencrypt:/etc/letsencrypt \
    -v certbot-logs:/var/log/letsencrypt \
    certbot/certbot:latest \
    certonly \
    --manual \
    --server https://acme-v02.api.letsencrypt.org/directory \
    --email executor55@gmx.de \
    --no-eff-email \
    --agree-tos \
    --preferred-challenges dns-01 \
    -d 3x3cut0r.de \
    -d *.3x3cut0r.de

```

# 4. configure two TXT-records in your public-dns <a name="txt-records"></a>
```shell
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Requesting a certificate for 3x3cut0r.de and *.3x3cut0r.de
Performing the following challenges:
dns-01 challenge for 3x3cut0r.de
dns-01 challenge for 3x3cut0r.de

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name
_acme-challenge.3x3cut0r.de with the following value:

LGxreq07B0iVOmxxQLWE0ZaMn-pqQ20JOATYKPFprXE

Before continuing, verify the record is deployed.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name
_acme-challenge.3x3cut0r.de with the following value:

dhfTQ6vybx1LYcgjFho-0DvdOO1IxtLoF5Tn7i4xX4A

Before continuing, verify the record is deployed.
(This must be set up in addition to the previous challenges; do not remove,
replace, or undo the previous challenge tasks yet. Note that you might be
asked to create multiple distinct TXT records with the same name. This is
permitted by DNS standards.)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue

```

# schedule renewal with a systemd-timer as root <a name="renewal"></a>
**/lib/systemd/system/certbot-renewal.timer**
```shell
[Unit]
Description=timer to renew certbot certificates

[Timer]
OnCalendar=daily
Unit=certbot-renewal.service
Persistent=true

[Install]
WantedBy=multi-user.target

```
**/lib/systemd/system/certbot-renewal.service**
```shell
[Unit]
Description=service to renew certbot certificates

[Service]
User=docker
ExecStart=/home/docker/bin/docker container run --rm -it -v certbot-letsencrypt:/etc/letsencrypt -v certbot-logs:/var/log/letsencrypt certbot/certbot:latest renew

```
**enable timer**
```shell
systemctl daemon-reload
systemctl enable certbot-renewal.timer

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.


version: "3.9"

services:
    certbot:
        container_name: certbot
        image: certbot/certbot:latest
        restart: unless-stopped
        command: certonly --webroot --webroot-path=/var/www/certbot --email julianreith@gmx.de --agree-tos --no-eff-email --force-renewal -d 3x3cut0r.de -d *.3x3cut0r.de
        networks:
            nginx:
                ipv4_address: 10.24.0.3
        volumes:
            - certbot-conf:/etc/letsencrypt
            - certbot-logs:/var/log/letsencrypt
            - certbot-data:/var/www/certbot
networks:
    nginx:
      external:
            name: nginx

volumes:
    certbot-conf:
        name: certbot-conf
    certbot-data:
        name: certbot-data
    certbot-logs:
        name: certbot-logs
