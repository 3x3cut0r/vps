# docker rootless mode

**script to install docker + docker-compose in rootless mode on debian 10**  

## Index

1. [Usage](#usage)  
  1.1 [first-run: install prerequisites](#first_run)  
  1.2 [second-run: install docker](#second_run)  
  1.3 [use docker](#use_docker)  
  
\# [Find Me](#findme)  
\# [License](#license)  

# 2. Usage <a name="usage"></a>

## 2.1 download and run script first time as root <a name="first_run"></a>
login (via ssh) on your guest as docker and switch user to root:
```shell
ssh docker@192.168.0.254
su -
```
on your guest:
```shell
apt install wget -y
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/docker-rootless.sh -O /opt/docker-rootless.sh
chmod +x /opt/docker-rootless.sh
/opt/docker-rootless.sh --prepare

```

## 2.2 run script second time as docker <a name="second_run"></a>
login (via ssh) on your guest as docker:
```shell
ssh docker@192.168.0.254
```
on your guest:
```shell
/opt/docker-rootless.sh --install

```

## 2.3 use docker only with user docker <a name="use_docker"></a>
login (via ssh) on your guest as docker:
```shell
ssh docker@192.168.0.254
```
on your guest:
```shell
docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

### # Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### # License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
