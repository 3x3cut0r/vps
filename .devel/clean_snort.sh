#!/bin/bash
# Author:   3x3cut0r <executor55@gmx.de>
# Version:  0.01
# Date:     2021-10-12
#
# Description:
#  restarts snort3 and fail2ban and clean all bans
#

SNORT_USERNAME="snort"
SNORT_UID="3000"

# check root
function check_root () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1: check root "
    if [[ $(id -u) -eq 0 ]]; then
        printf '\n\e[0;32m%-6s\e[m\n' " ==> you are root "
    else
        printf '\n\e[0;31m%-6s\e[m\n' " ==> you need login as root "
        exit 1
    fi
}

# stop fail2ban
function stop_fail2ban () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1: stop fail2ban "
    systemctl stop fail2ban
}

# stop snort3
function stop_snort3 () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1: stop snort3 "
    systemctl stop snort3
}

# start fail2ban
function start_fail2ban () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1: start fail2ban "
    systemctl start fail2ban
}

# start snort3
function start_snort3 () {
    printf '\n\e[1;31m%-6s\e[m\n\n' " ==> Step 1: start snort3 "
    systemctl start snort3
}

# clear sshd bans
function clear_sshd_bans () {
    f2bjail=sshd
    echo ""
    read -p "Do you want to clear fail2ban filter $f2bjail? (y/N):  "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        for ip in "$(fail2ban-client status $f2bjail | tail -n +9 | tail -c +23 | tr ' ' '\n')"; do fail2ban-client unban $ip; done
        printf '\n\e[0;32m%-6s\e[m\n' " ==> $f2bjail filter cleared "
    else
        printf '\n\e[0;34m%-6s\e[m\n' " ==> $f2bjail filter skipped "
    fi
}

# clear snort3 bans
function clear_snort3_bans () {
    f2bjail=snort3
    echo ""
    read -p "Do you want to clear fail2ban filter $f2bjail? (y/N):  "
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        f2bjail=sshd
        for ip in "$(fail2ban-client status $f2bjail | tail -n +9 | tail -c +23 | tr ' ' '\n')"; do fail2ban-client unban $ip; done
        printf '\n\e[0;32m%-6s\e[m\n' " ==> $f2bjail filter cleared "
    else
        printf '\n\e[0;34m%-6s\e[m\n' " ==> $f2bjail filter skipped "
    fi
}























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

    # apt: prerequisites
    printf '\n\e[0;33m%-6s\e[m\n' " ==> apt: install prerequisites ... "
    apt update && apt upgrade -y
    apt install \
            curl \
            openssh-server \
            sudo \
            uidmap \
            unzip \
            wget \
            -y

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
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker: install rootless docker ... "
    if  [[ -f /home/"$DOCKER_USERNAME"/bin/docker ]] || [[ -f /usr/local/bin/docker ]] || [[ -f /usr/bin/docker.io ]]; then
        which docker
        printf '\e[1;31m%-6s\e[m\n\n' "Docker is already installed. Abort"
        exit 1
    fi

    # install rootless docker
    if [ $UID -eq 0 ]; then echo "You need to login (via ssh) as $DOCKER_USERNAME (uid=$DOCKER_UID) to install rootless docker!"; exit 1; fi
    curl -fsSL https://get.docker.com/rootless | sh
    sudo loginctl enable-linger docker

    # set docker-compose version
    DOCKER_COMPOSE_VERSION=$(curl -L "https://docs.docker.com/compose/install/" | grep -o -P '(?<=https://github.com/docker/compose/releases/download/).*(?=/docker-compose)' | head -n1)
    if [ $DOCKER_COMPOSE_VERSION = "" ]; then DOCKER_COMPOSE_VERSION="1.28.4"; fi
    printf '\n\e[0;33m%-6s\e[m\n' " ==> docker-compose: install rootless docker-compose ... "
    read -p "Which docker-compose version do you want to install? ($DOCKER_COMPOSE_VERSION): "
    if [ ! -z $REPLY ]; then
        if [ $(id -u $REPLY 2> /dev/null ) ]; then
            DOCKER_COMPOSE_VERSION=$REPLY
        fi
    fi

    # install rootless docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    # install docker-compose bash completion
    sudo curl -L "https://raw.githubusercontent.com/docker/compose/$DOCKER_COMPOSE_VERSION/contrib/completion/bash/docker-compose" -o /etc/bash_completion.d/docker-compose

    # prepare ~/.bashrc
    echo -e "\n# Docker environment variables" >> ~/.bashrc
    echo "if [[ ! \$(echo \$PATH | grep /home/$DOCKER_USERNAME/bin) ]]; then" >> ~/.bashrc
    echo "    export PATH=/home/$DOCKER_USERNAME/bin:\$PATH" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
    echo "export DOCKER_HOST=unix:///run/user/$DOCKER_UID/docker.sock" >> ~/.bashrc

    # prepare /etc/sudoers
    if [[ ! $(sudo cat /etc/sudoers | grep secure_path | grep /home/docker/bin) ]]; then
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
    sudo /usr/sbin/reboot
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