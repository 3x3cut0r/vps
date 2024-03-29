#!/bin/bash
# Author:   3x3cut0r <executor55@gmx.de>
# Version:  1.03
# Date:     2022-03-04
#
# Description:
#  this script installs docker and docker-compose in rootless mode on debian 10 / 11
#

DOCKER_USERNAME="docker"
DOCKER_UID="1000"
DEBIAN_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d= -f2 | tr -d '"')

# change username
function username () {
    if [[ $(id -u $DOCKER_USERNAME) -ge 1000 ]]; then
        DOCKER_UID=$(id -u $DOCKER_USERNAME)
    fi
    echo ""
    read -p "Enter the username under which the docker service should run. ($DOCKER_USERNAME): "
    if [ ! -z $REPLY ]; then
        DOCKER_USERNAME=$REPLY
    fi

    if [ $(id -u $DOCKER_USERNAME 2> /dev/null ) ]; then
        DOCKER_UID="$(id -u $DOCKER_USERNAME)"
    else
        printf '\e[1;31m%-6s\e[m\n'  "username: $DOCKER_USERNAME does not exist."
        read -p "Do you want to create it? (n/Y): "
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            read -p "Enter new UID/GID ($DOCKER_UID): "
            if [ ! -z "$REPLY" ]; then
                DOCKER_UID=$REPLY
            fi
            addgroup --gid $DOCKER_UID $DOCKER_USERNAME
            adduser --uid $DOCKER_UID --gid $DOCKER_UID --shell /bin/bash --disabled-password --gecos '' $DOCKER_USERNAME
        else
            printf '\e[1;31m%-6s\e[m\n'  "you need a docker user ... aborting"
            exit 1
        fi
    fi
    echo ""
    echo "DOCKER_USERNAME: $DOCKER_USERNAME (uid=$DOCKER_UID)"
}

# first run as root
function prepare () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1/2: prepare environment "

    # check first run
    read -p "Do you want to continue with Step 1? (y/N): "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "exited by user\n"
        exit 1
    fi

    # check root
    if [ $UID -ne 0 ]; then
        printf '\e[1;31m%-6s\e[m\n\n' "run as root (uid=0) to install prerequisites"
        echo -e "If you want do install docker rootless, do:\n ./docker_rootless.sh install\n"
        exit 1
    fi

    # apt: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> apt: install prerequisites ... "
    apt update && apt upgrade -y
    apt install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            iptables \
            openssh-server \
            software-properties-common \
            sudo \
            uidmap \
            unzip \
            wget \
            -y
    if [[ $DEBIAN_VERSION -eq "11" ]]; then
        apt install \
                dbus-user-session \
                fuse-overlayfs \
                slirp4netns \
                -y
    fi

    # vim: arrow key fix
    printf '\n\e[0;33m%-6s\e[m\n' " ==> vim: arrow key fix ... "
    sed -i s/set\ compatible/set\ nocompatible/g /etc/vim/vimrc.tiny

    # sudo: add docker to sudo group
    printf '\n\e[0;33m%-6s\e[m\n' " ==> sudo: add docker to sudo group ... "
    usermod -aG sudo $DOCKER_USERNAME

    # docker: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker: prepare system ... "
    echo -e "# docker rootless mode prerequisites:\nkernel.unprivileged_userns_clone=1" > /etc/sysctl.d/docker_rootless.conf
    sysctl --system
    modprobe overlay permit_mounts_in_userns=1

    # enable vm.overcommit_memory
    sysctl vm.overcommit_memory=1
    if [[ ! $(cat /etc/sysctl.conf | grep vm.overcommit_memory) ]]; then
        echo -e "\n# enable vm.overcommit_memory (e.g. for redis)" >> /etc/sysctl.conf
        echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
    fi

    # enable-linger
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker: loginctl enable-linger $DOCKER_USERNAME "
    loginctl enable-linger $DOCKER_USERNAME

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot, login with root, passwd $DOCKER_USERNAME, logout, then login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to continue with './docker_rootless.sh --install'"
    read -n 1 -s -r -p "press any key to continue ..."
    if [[ $DEBIAN_VERSION -eq "11" ]]; then
        /usr/sbin/reboot
    else
        /sbin/reboot
    fi
}

# second run as docker
function install () {
    printf '\n\e[1;31m%-6s\e[m\n\n'  " ==> Step 2/2: install docker rootless "

    # check second run
    read -p "Do you want to continue with Step 2? (y/N): "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "exited by user\n"
        exit 1
    fi

    # check docker already installed
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker: install rootless docker ... "
    if  [[ -f /home/"$DOCKER_USERNAME"/bin/docker ]] || [[ -f /usr/local/bin/docker ]] || [[ -f /usr/bin/docker.io ]]; then
        which docker
        printf '\e[1;31m%-6s\e[m\n\n' "Docker is already installed. Abort"
        exit 1
    fi

    # install rootless docker
    if [ $UID -eq 0 ]; then echo "You need to login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to install rootless docker!"; exit 1; fi
    curl -fsSL https://get.docker.com/rootless | sh

    # set docker-compose v1 version
    DOCKER_COMPOSE_VERSION=$(curl -L "https://docs.docker.com/compose/install/" | grep -o -P '(?<=https://github.com/docker/compose/releases/download/).*(?=/docker-compose)' | head -n1)
    if [ $DOCKER_COMPOSE_VERSION = "" ]; then DOCKER_COMPOSE_VERSION="1.29.2"; fi
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker-compose v1: install docker-compose v$DOCKER_COMPOSE_VERSION ... "
    read -p "Which docker-compose v1 version do you want to install? ($DOCKER_COMPOSE_VERSION): "
    if [ ! -z $REPLY ]; then
        if [ $(id -u $REPLY 2> /dev/null ) ]; then
            DOCKER_COMPOSE_VERSION=$REPLY
        fi
    fi

    # install rootless docker-compose v1
    sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    # install docker-compose bash completion
    sudo curl -L "https://raw.githubusercontent.com/docker/compose/$DOCKER_COMPOSE_VERSION/contrib/completion/bash/docker-compose" -o /etc/bash_completion.d/docker-compose

    # install rootless docker-compose v2
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    DOCKER_COMPOSE_VERSION_v2=$(curl -L https://docs.docker.com/compose/cli-command/#install-on-linux | grep '<span class="go"> Docker Compose version' | cut -d' ' -f6)
    if [ $DOCKER_COMPOSE_VERSION_v2 = "" ]; then DOCKER_COMPOSE_VERSION_v2="2.2.3"; fi
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker-compose v2: install docker-compose v$DOCKER_COMPOSE_VERSION_v2 ... "
    mkdir -p $DOCKER_CONFIG/cli-plugins
    sudo curl -SL https://github.com/docker/compose/releases/download/v$DOCKER_COMPOSE_VERSION_v2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
    docker compose version

    # install compose switch
    DOCKER_COMPOSE_SWITCH_VERSION=$(curl -L https://github.com/docker/compose-switch/releases | grep /docker/compose-switch/releases/download/ | head -n1 | grep -o -P '(?<=/docker/compose-switch/releases/download/).*(?=/docker-compose)')
    if [ $DOCKER_COMPOSE_SWITCH_VERSION = "" ]; then DOCKER_COMPOSE_SWITCH_VERSION="v1.0.4"; fi
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker compose switch: install docker compose switch $DOCKER_COMPOSE_SWITCH_VERSION ... "
    sudo curl -fL https://github.com/docker/compose-switch/releases/download/$DOCKER_COMPOSE_SWITCH_VERSION/docker-compose-linux-amd64 -o /usr/local/bin/compose-switch
    sudo chmod +x /usr/local/bin/compose-switch
    sudo mv /usr/local/bin/docker-compose /usr/local/bin/docker-compose-v1
    sudo update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/docker-compose-v1 1
    sudo update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/compose-switch 99
    sudo update-alternatives --display docker-compose

    # prepare ~/.bashrc
    echo -e "\n# Docker environment variables" >> ~/.bashrc
    echo "export XDG_RUNTIME_DIR=/home/$DOCKER_USERNAME/.docker/run" >> ~/.bashrc
    echo "if [[ ! \$(echo \$PATH | grep /home/$DOCKER_USERNAME/bin) ]]; then" >> ~/.bashrc
    echo "    export PATH=/home/$DOCKER_USERNAME/bin:\$PATH" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "export DOCKER_HOST=unix:///run/user/$DOCKER_UID/docker.sock" >> ~/.bashrc

    # prepare /etc/sudoers
    if [[ ! $(sudo cat /etc/sudoers | grep secure_path | grep /home/$DOCKER_USERNAME/bin) ]]; then
        sudo sed -i "s#secure_path=\"#secure_path=\"/home/$DOCKER_USERNAME/bin:#g" /etc/sudoers
    fi
    if [[ ! $(sudo cat /etc/sudoers | grep env_keep | grep DOCKER_HOST) ]]; then
        LINENR=$(sudo awk '/secure_path/{ print NR; exit }' /etc/sudoers)
        let LINENR+=1
        sudo sed -i "$(echo $LINENR)iDefaults\tenv_keep += DOCKER_HOST" /etc/sudoers
    fi

    # setcap cap_net_bind_service=ep /home/docker/bin/rootlesskit
    read -p "Do you want to allow docker-rootless to bind unprivileged ports (<1024)? (y/N): "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        sudo setcap cap_net_bind_service=ep /home/$DOCKER_USERNAME/bin/rootlesskit
    fi

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot ... login with docker ... and use 'docker ...'"
    printf '\e[0;33m%-6s\e[m\n\n' " ==> OPTIONAL: remove $DOCKER_USERNAME from sudo group (sudo deluser $DOCKER_USERNAME sudo)"
    read -n 1 -s -r -p "press any key to reboot ..."
    if [[ $DEBIAN_VERSION -eq "11" ]]; then
        sudo /usr/sbin/reboot
    else
        sudo /sbin/reboot
    fi
}

function help () {
    printf "USAGE:\n"
    printf "  ./docker-rootless.sh [OPTIONS]\n\n"
    printf "OPTIONS:\n"
    printf "  --prepare\trun as root (uid=0) to install prerequisites\n\n"
    printf "  --install\trun as $DOCKER_USERNAME (uid=$DOCKER_UID) to install docker rootless-mode\n\n"
}

if [ $# -eq 0 ]; then help; fi
arg="$1"
case "$arg" in
    "--first" | "--first-run" | "--prepare" | "first" | "first-run" | "1" | "prepare" )
    username
    prepare
    ;;
    "--second" | "--second-run" | "--install" | "second" | "second-run" | "2" | "install" )
    username
    install
    ;;
esac
