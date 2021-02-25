# Basic VPS tools

installation scripts for basic vps tools and services

# 1. System tools
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vserver/main/basics/system_tools.sh -O system_tools.sh
chmod +x system_tools.sh
./system_tools.sh
rm system_tools.sh

```

# 2. UFW (uncomplicated firewall)
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vserver/main/basics/ufw.sh -O ufw.sh
chmod +x ufw.sh
# 22 = ssh port
./ufw.sh 22
rm ufw.sh

```
to enable other ports:
```shell
# open port 80 (http):
ufw allow 80/tcp
# open port 80 only for specific ip
ufw allow from 101.2.3.104 to any port 80/udp

```

# 3. Fail2Ban (IP-Filter, Brute-Force protection)
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vserver/main/basics/fail2ban.sh -O fail2ban.sh
chmod +x fail2ban.sh
./fail2ban.sh
rm fail2ban.sh

```
show fail2ban status (jail list):
```shell
fail2ban-client status
Status
|- Number of jail:	1
`- Jail list:	sshd
```
show specific jail (sshd):
```shell
fail2ban-client status sshd
Status for the jail: sshd
|- Filter
|  |- Currently failed:	1
|  |- Total failed:	6
|  `- File list:	/var/log/auth.log
`- Actions
   |- Currently banned:	1
   |- Total banned:	1
   `- Banned IP list:	61.177.173.25
```
unban single ip from specific jail (sshd):
```shell
fail2ban-client set sshd unbanip 61.177.173.25
```
unban single ip from all jails:
```shell
fail2ban-client unban 61.177.173.25
```
unban all ips:
```shell
fail2ban-client unban --all
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
