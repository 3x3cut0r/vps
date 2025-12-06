# CrowdSec

an open-source and participative security solution offering crowdsourced server detection and protection against malicious IPs.

## Index

0. [Installation](#install)
1. [Collection](#collection)  
   1.1 [sshd](#sshd)
2. [Bouncer](#bouncer)  
   2.1 [firewall-bouncer-iptables](#firewall-bouncer-iptables)
3. [Statistics](#statistics)  
   3.1 [show metrics](#metrics)  
   3.2 [show decisions](#decisions)

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

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
