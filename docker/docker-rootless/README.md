# docker rootless mode

**script to install docker + docker-compose in rootless mode on debian 10**  

## Index

1. [Usage](#usage)  
  1.1 [first-run: install prerequisites](#first_run)  
  1.2 [second-run: install docker](#second_run)  
  1.3 [use docker](#use_docker)  
  1.4 [remove docker from sudo group](#rm_from_sudo)  
  1.5 [stop / start docker.serivce](#stop_start)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. Usage <a name="usage"></a>

## 1.1 download and run script first time as root <a name="first_run"></a>
login (via ssh) to your vps as docker and switch user to root:
```shell
apt install wget -y
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/docker-rootless/docker-rootless.sh -O /opt/docker-rootless.sh
chmod +x /opt/docker-rootless.sh
/opt/docker-rootless.sh --prepare

```

## 1.2 run script second time as docker <a name="second_run"></a>
login (via ssh) to your vps as user docker:
```shell
/opt/docker-rootless.sh --install

```

## 1.3 use docker only with user docker <a name="use_docker"></a>
login (via ssh) to your vps as docker:
```shell
docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

## 1.4 OPTIONAL: remove docker from sudo group <a name="rm_from_sudo"></a>
login (via ssh) to your vps as docker:
```shell
sudo deluser docker sudo

```

## 1.5 stop / start / restart docker.service <a name="stop_start"></a>
login (via ssh) to your vps as docker:
```shell
systemctl --user start docker.service
systemctl --user stop docker.service
systemctl --user restart docker.service

```

### # Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### # License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
