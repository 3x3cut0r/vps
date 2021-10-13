# WebDAV

WebDAV (Web Distributed Authoring and Versioning) is an extension of the Hypertext Transfer Protocol (HTTP) that allows clients to perform remote Web content authoring operations. WebDAV is defined in RFC 4918 by a working group of the Internet Engineering Task Force (IETF).

**in this context used to expand the hard disk space of the vps via the internet**

## Index

1. [prerequisites](#prerequisites)
2. [install DAVfs filesystem](#install)  
3. [mount DAVfs filesystem (manual)](#mount_manual)  
4. [store credentials permanent](#credentials)  
5. [download and store (self-signed) certificate](#certificate)
6. [schedule automated certificate download with a systemd-timer as root](#mount_fstab)  
7. [mount DAVfs filesystem (fstab)](#mount_fstab)  

\# [Find Me](#findme)  
\# [License](#license)  

## 1. prerequisites <a name="prerequisites"></a>  
* a WebDAV Server somewhere else (e.g.: private Synology DiskStation) who provides user credentials

# 2. install DAVfs filesystem <a name="install"></a>
```shell
apt install davfs2

```

## 3. mount DAVfs filesystem (manual)<a name="mount_manual"></a>  
```shell
mount.davfs https://<your_domain>:<your_port>/<path> /mnt

<enter username and password>

```


## 4. store credentials permanent<a name="credentials"></a>  
**/etc/davfs2/secrets**  
```shell
...

/mnt    benutzername    "passwort"

```

## 5. download and store (self-signed) certificate<a name="certificate"></a>  
**download (self-signed) certificate**  
```shell
openssl s_client -connect <your_domain>:<your_port> -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM > /etc/davfs2/certs/certificate.pem

```
**enable trust_server_cert in /etc/davfs2/davfs2.conf**  
```shell
...
trust_server_cert /etc/davfs2/certs/certificate.pem
...

```

## 6 schedule automated certificate download with a systemd-timer as root <a name="renewal"></a>
**[/lib/systemd/system/webdav-certificate-renewal.timer](https://github.com/3x3cut0r/vps/blob/main/docker/lib/systemd/system/webdav-certificate-renewal.timer)**
```shell
[Unit]
Description=timer to renew webdav certificate

[Timer]
OnCalendar=daily
Unit=webdav-certificate-renewal.service
Persistent=true

[Install]
WantedBy=multi-user.target

```
**[/lib/systemd/system/webdav-certificate-renewal.service](https://github.com/3x3cut0r/vps/blob/main/docker/lib/systemd/system/webdav-certificate-renewal.service)**
```shell
Description=service to renew webdav certificate
Wants=webdav-certificate-renewal.timer

[Service]
Type=simple
User=root
ExecStart=openssl s_client -showcerts -servername webdav.3x3cut0r.synology.me -connect webdav.3x3cut0r.synology.me:443 </dev/null | openssl x509 -outform PEM > /etc/davfs2/certs/3x3cut0r.synology.me.pem
RemainAfterExit=true

[Install]
WantedBy=multi-user.target

```
**enable timer**
```shell
systemctl daemon-reload
systemctl enable webdav-certificate-renewal.timer

```

## 7. mount DAVfs filesystem (fstab)<a name="mount_fstab"></a>  
**step 4-6 need to be done first!**  
**/etc/fstab**  
```shell
https://<your_domain>:<your_port>/<path> /mnt davfs user,rw,noauto 0 0

```

**test fstab**  
```shell
mount /mnt

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
