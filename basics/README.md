# Basic VPS tools

installation scripts for basic vps tools and services

## Index

1. [tools](#tools)  
2. [change Hostname](#hostname)  
3. [ufw](#ufw)  
4. [set locale](#locale)  
5. [fail2ban](#fail2ban)   
6. [adduser](#adduser)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. tools <a name="tools"></a>
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/tools.sh -O tools.sh
chmod +x tools.sh
./tools.sh
rm tools.sh

```

# 2. change hostname <a name="hostname"></a>
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/change_hostname.sh -O change_hostname.sh
chmod +x change_hostname.sh
./change_hostname.sh vps.3x3cut0r.de
rm change_hostname.sh

```

# 3. ufw (uncomplicated firewall) <a name="ufw"></a>
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/ufw.sh -O ufw.sh
chmod +x ufw.sh
# 22 = ssh port
./ufw.sh 22
rm ufw.sh

```
add rules: (allow 80/tcp for http)
```shell
# open port 80 (http):
ufw allow 80/tcp
# open port 80 only for specific ip
ufw allow from 101.2.3.104 to any port 80/udp

```
remove rules: (allow 80/tcp for http)
```shell
ufw delete allow 80/tcp

```

# 4. set locale (prevent perl error with locale)<a name="locale"></a>
you can replace "en_US.UTF-8" with whatever you want (e.g.: "de_DE.UTF-8")
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/locale-gen.sh -O locale-gen.sh
chmod +x locale-gen.sh
./locale-gen en_US.UTF-8
rm locale-gen.sh

```

# 5. fail2ban (IP-Filter, Brute-Force protection) <a name="fail2ban"></a>
install:
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/fail2ban.sh -O fail2ban.sh
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

# 6. adduser <a name="adduser"></a>
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/adduser.sh -O adduser.sh
chmod +x adduser.sh
# john = username of new user
./adduser.sh john
rm adduser.sh

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
