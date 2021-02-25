#!/bin/bash
# install ufw (uncomplicated firewall)
apt install ufw
# allow SSH
ufw allow 22/tcp
# turn on ufw
ufw enable
# show status
ufw status
