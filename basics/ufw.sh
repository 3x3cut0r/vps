#!/bin/bash
# to enable other ssh port: ./ufw.sh <port>
# ./ufw.sh 22222
#
SSH_PORT=22
# install ufw (uncomplicated firewall)
apt install ufw ipset -y
# allow SSH
if [ $1 -gt 0 ]; then
    SSH_PORT="$1"
fi
ufw allow 'OpenSSH'
# turn on ufw
ufw enable
# show status
ufw status
