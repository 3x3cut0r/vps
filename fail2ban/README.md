# fail2ban

automatically block ips after a certain number of failed login attempts

## Index

1. [installation](#installation)  
2. [show](#show)  
    2.1 [show fail2ban status (all)](#status_all)  
    2.2 [show fail2ban status (specific)](#status_specific)  
    2.3 [show ipset list](#ipset_list)  
3. [unban](#unban)  
    3.1 [unban single ip from specific jail](#unban_single)  
    3.2 [unban single ip from all jails](#unban_single_all)  
    3.3 [unban all ips](#unban_all)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. installation <a name="installation"></a>
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/basics/fail2ban.sh -O fail2ban.sh
chmod +x fail2ban.sh
./fail2ban.sh
rm fail2ban.sh

```

# 2. show <a name="show"></a>

## 2.1 show fail2ban status (all) <a name="status_all"></a>
```shell
fail2ban-client status
Status
|- Number of jail:	2
`- Jail list:	portainer, sshd
```

## 2.2 show fail2ban status (sshd) <a name="status_specific"></a>
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

## 2.3 show ipset list <a name="ipset_list"></a>
```shell
ipset list sshd
Name: f2b-sshd
Type: hash:ip
Revision: 4
Header: family inet hashsize 1024 maxelem 65536 timeout 1209600
Size in memory: 280
References: 1
Number of entries: 1
Members:
61.177.173.25 timeout 1209554

```

# 3. unban <a name="unban"></a>

## 3.1 unban single ip from specific jail (sshd) <a name="unban_single"></a>
```shell
fail2ban-client set sshd unbanip 61.177.173.25
```

## 3.2 unban single ip from all jails <a name="unban_single_all"></a>
```shell
fail2ban-client unban 61.177.173.25
```

## 3.3 unban all ips <a name="unban_all"></a>
```shell
fail2ban-client unban --all
```

## 3.4 unban all ips from specific jail (sshd) <a name="unban_all"></a>
```shell
f2bjail=sshd
for ip in "$(fail2ban-client status $f2bjail | tail -n +9 | tail -c +23 | tr ' ' '\n')"; do fail2ban-client unban $ip; done

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
