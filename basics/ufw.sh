#!/bin/bash
# to enable other ssh port: ./ufw.sh <port>
# ./ufw.sh 22222
#
SSH_PORT=22
# install ufw (uncomplicated firewall)
apt install ufw -y
# allow SSH
if [ $1 -gt 0 ]; then
    SSH_PORT="$1"
fi
ufw allow $SSH_PORT/tcp
# turn on ufw
ufw enable
# show status
ufw status
