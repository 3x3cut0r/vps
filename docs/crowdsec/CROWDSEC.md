# CrowdSec

an open-source and participative security solution offering crowdsourced server detection and protection against malicious IPs.

## Index

0. [Installation](#install)  
   0.1 [LAPI vs Collections vs Bouncer](#lapi)
1. [Collection](#collection)  
   1.1 [sshd](#sshd)
2. [Bouncer](#bouncer)  
   2.1 [firewall-bouncer-iptables](#firewall-bouncer-iptables)
3. [Statistics](#statistics)  
   3.1 [show metrics](#metrics)  
   3.2 [show decisions](#decisions)
4. [Add other machines to crowdsec LAPI on pve host](#machines)  
   4.1 [Add lxc-110 (npm)](#npm)

\# [Find Me](#findme)  
\# [License](#license)

# 0. Installation <a name="install"></a>

```bash
# install on proxmox host and all LXC container to protect:
curl -s https://install.crowdsec.net | sudo sh
apt update
apt install crowdsec

# check installation
systemctl status crowdsec
cscli version
```

### 0.1 LAPI vs Collections vs Bouncer <a name="lapi"></a>

**Local API (LAPI)**

- on the proxmox host as central management
- receives alerts from collections
- create and manage decisions
- serve decisions to bouncers

**Collection (Agent)**

- on a machine where an application produces logs (proxmox + lxc)
- example collections: sshd, http ...

**Bouncer**

- on a machine wherever you want to block traffic
- enforce decisions created by the LAPI
- connect to LAPI and pull ban list
- apply ans using methods
- example methods: iptables, nftables, ...

# 1. Collection <a name="collection"></a>

### 1.1 sshd <a name="sshd"></a>

```bash
# install ssh collection
cscli collections install crowdsecurity/sshd
cscli hub update
systemctl reload crowdsec
```

# 2. Bouncer <a name="bouncer"></a>

### 2.1 firewall-bouncer-iptables <a name="firewall-bouncer-iptables"></a>

```bash
# install firewall-bouncer-iptables
apt install crowdsec-firewall-bouncer-iptables
```

# 3. Statistics <a name="statistics"></a>

### 3.1 show metrics <a name="metrics"></a>

```bash
# show metrics
cscli metrics
```

### 3.2 show decisions <a name="decisions"></a>

```bash
# check decisions
cscli decisions list
```

# 4. Add other machines to crowdsec LAPI on pve host <a name="machines"></a>

### 4.1 Add lxc-110 (npm) <a name="npm"></a>

```bash
# on proxmox: add machine lxc-110 (npm)
cscli machines add lxc-110 --auto --force
# check added machine
cscli machines list

# check your credentials
cat /etc/crowdsec/local_api_credentials.yaml

# to delete a machine
# cscli machines delete nginx-lxc-110

# on lxc-110
cat >/etc/crowdsec/local_api_credentials.yaml <<EOF
url: http://192.168.40.1:8080/
login: lxc-110
password: <PASSWORD>
EOF
systemctl restart crowdsec.service
cscli lapi status
# expected output: You can successfully interact with Local API (LAPI)

# on proxmox
cscli machines list
# you should see lxc-110 on the list
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
