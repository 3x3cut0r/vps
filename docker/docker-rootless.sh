#!/bin/bash
# Author:   3x3cut0r <executor55@gmx.de>
# Version:  1.01
# Date:     2021-03-01
#
# Description:
#  this script installs a rootless docker-host on a debian 10
#

DOCKER_USERNAME="docker"
DOCKER_UID="1000"

# change username
function username () {
    if [[ $(id -u $DOCKER_USERNAME) -ge 1000 ]]; then
        DOCKER_UID=$(id -u $DOCKER_USERNAME)
    fi
    echo ""
    read -p "Enter the username under which the docker service should run. ($DOCKER_USERNAME): "
    if [ ! -z $REPLY ]; then
        if [ $(id -u $REPLY 2> /dev/null ) ]; then
            DOCKER_USERNAME=$REPLY
            DOCKER_UID="$(id -u $DOCKER_USERNAME)"
        else
            printf '\e[1;31m%-6s\e[m\n'  "username: $REPLY does not exits "
            echo "using $DOCKER_USERNAME instead"
        fi
    fi
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

    # APT: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> APT: install prerequisites ... "
    apt update && apt upgrade -y
    apt install \
            curl \
            openssh-server \
            sudo \
            uidmap \
            unzip \
            wget \
            -y

    # VI: arrow key fix
    printf '\n\e[0;33m%-6s\e[m\n' " ==> VI: arrow key fix ... "
    sed -i s/set\ compatible/set\ nocompatible/g /etc/vim/vimrc.tiny

    # SSH: PermitRootLogin (optional)
    printf '\n\e[0;33m%-6s\e[m\n' " ==> SSH: PermitRootLogin ... "
    read -p "Do you want to permit root login via ssh? (y/N): "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sed -i s/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g /etc/ssh/sshd_config
        # systemctl restart sshd
    fi

    # SUDO: add docker to sudo group
    printf '\n\e[0;33m%-6s\e[m\n' " ==> SUDO: add docker to sudo group ... "
    read -p "Do you want to add docker to sudo group? (y/N): "
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        usermod -aG sudo $DOCKER_USERNAME
    fi

    # docker: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker: prepare system ... "
    echo -e "# docker rootless mode prerequisites:\nkernel.unprivileged_userns_clone=1" > /etc/sysctl.d/docker_rootless.conf
    sysctl --system
    modprobe overlay permit_mounts_in_userns=1

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot, then login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to continue with './docker_rootless.sh --install'"
    read -n 1 -s -r -p "press any key to continue ..."
    /usr/sbin/reboot
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
    printf '\n\e[0;33m%-6s\e[m\n' " ==> Docker: install rootless docker ... "
    if  [[ -f /home/"$DOCKER_USERNAME"/bin/docker ]] || [[ -f /usr/local/bin/docker ]] || [[ -f /usr/bin/docker.io ]]; then
        which docker
        printf '\e[1;31m%-6s\e[m\n\n' "Docker is already installed. Abort"
        exit 1
    fi

    # install rootless docker
    if [ $UID -eq 0 ]; then echo "You need to login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to install rootless docker!"; exit 1; fi
    curl -fsSL https://get.docker.com/rootless | sh
    if sudo ls > /dev/null; then
        sudo loginctl enable-linger docker
    else
        echo -e "\nenter 'loginctl enable-linger docker' as root"
        echo "to start docker daemon on system start automatically"
        echo "OR:"
        echo "systemctl --user start docker"
        echo "to start docker manually"
    fi

    # set docker-compose version
    DOCKER_COMPOSE_VERSION=$(curl -L "https://docs.docker.com/compose/install/" | grep -o -P '(?<=https://github.com/docker/compose/releases/download/).*(?=/docker-compose)' | head -n1)
    if [ $DOCKER_COMPOSE_VERSION = "" ]; then DOCKER_COMPOSE_VERSION="1.28.4"; fi
    read -p "Which docker-compose version do you want to install? ($DOCKER_COMPOSE_VERSION): "
    if [ ! -z $REPLY ]; then
        if [ $(id -u $REPLY 2> /dev/null ) ]; then
            DOCKER_COMPOSE_VERSION=$REPLY
        fi
    fi

    # install rootless docker-compose
    if sudo ls > /dev/null; then
        sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

        # install docker-compose bash completion
        sudo curl -L "https://raw.githubusercontent.com/docker/compose/$DOCKER_COMPOSE_VERSION/contrib/completion/bash/docker-compose" -o /etc/bash_completion.d/docker-compose
    fi

    # prepare ~/.bashrc
    echo -e "\n# Docker environment variables" >> ~/.bashrc
    echo "if [[ \$(echo \$PATH | grep /home/$DOCKER_USERNAME/bin) ]]; then" >> ~/.bashrc
    echo "    export PATH=/home/$DOCKER_USERNAME/bin:\$PATH" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "export DOCKER_HOST=unix:///run/user/$DOCKER_UID/docker.sock" >> ~/.bashrc

    # prepare /etc/sudoers
    if [[ ! $(cat /etc/sudoers | grep secure_path | grep /home/docker/bin) ]]; then
        sed -i "s#secure_path=\"#secure_path=\"/home/$DOCKER_USERNAME/bin:#g" /etc/sudoers
    fi

    # reboot
    printf '\n\e[0;33m%-6s\e[m\n' " ==> reboot ... login with docker ... and use 'docker ...'"
    if sudo ls > /dev/null; then
        read -n 1 -s -r -p "press any key to reboot ..."
        sudo /usr/sbin/reboot
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
