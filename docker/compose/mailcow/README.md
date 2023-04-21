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
# do this steps only if you want wo mount a folder into LXC
apt install cgroupfs-mount
echo “overlay” >> /etc/modules-load.d/modules.conf
echo "aufs" >> /etc/modules-load.d/modules.conf
reboot

```

**LXC Container System Requirements: unpriviledged=1, nesting=1, keyctl=1, 6GB RAM, 2CPU, 64GB HDD**

**on LXC**

```shell
dpkg-reconfigure tzdata
apt purge postfix
apt-get install msmtp-mta
echo "" >> /etc/bash.bashrc
echo "# send mail on logon" >> /etc/bash.bashrc
echo 'echo "ALERT - Shell Access on: $(date) $(who)" | mail -s "Alert: Shell Access on $(hostname -f)" root' >> /etc/bash.bashrc

vi /etc/msmtprc

vi /etc/aliases
```

**/etc/msmtprc**

```shell
# account default
defaults
auth            on
tls             on
tls_trust_file  /etc/ssl/certs/ca-certificates.crt
logfile         /var/log/msmtp.log
aliases         /etc/aliases

# gmail
account         gmail
host            smtp.gmail.com
port            587
tls_starttls    on
from            <your gmail address>@gmail.com
user            <your gmail address>@gmail.com
password        <a gmail generated app password for mail>

account default : gmail
```

**/etc/aliases**

```shell
postmaster: root
webmaster: root
root: <your gmail address>@gmail.com
local: <your gmail address>@gmail.com
default: <your gmail address>@gmail.com
```

# 2. clone and configure mailcow-dockerized project <a name="mailcow-dockerized"></a>

```shell
# install docker
curl -sSL https://get.docker.com/ | CHANNEL=stable sh
# After the installation process is finished, you may need to enable the service and make sure it is started (e.g. CentOS 7)
systemctl enable --now docker

# install docker-compose-plugin
apt install docker-compose-plugin

# install mailcow-dockerized
umask
# check if its 0022
cd /var
git clone https://github.com/mailcow/mailcow-dockerized
cd mailcow-dockerized
./generate_config.sh

vi mailcow.conf
# check config about your needs

vi docker-compose.yml
# in redis-mailcow section: comment out lines:
# sysctls:
# - net.core.somaxconn=4096

# in dovecot-mailcow section: modify
ulimits:
  nproc: 30000 #(Instead of 65535)

docker-compose up -d
```

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
