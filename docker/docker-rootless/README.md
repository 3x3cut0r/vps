# docker rootless mode

**script to install docker + docker-compose in rootless mode on debian 10**  

## Index

1. [Usage](#usage)  
  1.1 [first-run: install prerequisites](#first_run)  
  1.2 [second-run: install docker](#second_run)  
  1.3 [use docker](#use_docker)  
  1.4 [remove docker from sudo group](#rm_from_sudo)  
  1.5 [stop / start docker.serivce](#stop_start)  
2. [Update docker-rootless](#update)  

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

# 2. Update docker-rootless <a name="update"></a>
```shell
# UPDATE DOCKER-ROOTLESS (as user which docker-rootless runs with):
# stop your docker daemon ... (takes long time for me and doesn't finish problerly)
systemctl --user stop docker.service

# maybe you have to kill it because it hangs up and doesn't finish proberly
CTRL+C

# check that docker.service isn't running (important !!!)
systemctl --user status docker.service
# Active: inactive (dead)
# OR:
# Active: failed (Result: exit-code)

# download docker-rootless installation script
wget https://get.docker.com/rootless -O rootless.sh

# set environment variables (used by rootless.sh script)
SKIP_IPTABLES=1
FORCE_ROOTLESS_INSTALL=1

# remove "Already installed verification" check from script
sed -i s#\-x\ \"\$BIN/\$DAEMON\"#\!\ \-x\ \"\$BIN/\$DAEMON\"#g rootless.sh

# make rootless.sh executable
chmod +x rootless.sh

# run rootles.sh
./rootless.sh

# kill installation script, because it starts docker.service and keeps running
CTRL+C

# finaly setcap cap_net_bind_service (to bind ports less than 1024)
# replace 'docker' with the username you are logged in with
sudo setcap cap_net_bind_service=ep /home/docker/bin/rootlesskit

# DONE (docker should now be updated)
docker --version
# Docker version 20.10.5, build 363e9a8


# UPDATE DOCKER-COMPOSE (with sudo or root):
# get and save latest docker-compose version
DOCKER_COMPOSE_VERSION=$(curl -L "https://docs.docker.com/compose/install/" | grep -o -P '(?<=https://github.com/docker/compose/releases/download/).*(?=/docker-compose)' | head -n1)

# download docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# make it executable
sudo chmod +x /usr/local/bin/docker-compose

# link it to /usr/bin
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# DONE (docker-compose should now be updated)
docker-compose --version
# docker-compose version 1.29.0, build 07737305


# remove docker-rootless script
rm rootles.sh

# maybe you should reboot your host once!
sudo reboot
```

### # Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### # License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
