#!/bin/bash
apt install fail2ban -y
if [ $(cat /etc/fail2ban/jail.d/defaults-debian.conf | grep sshd) = "[sshd]" ]; then
    rm /etc/fail2ban/jail.d/defaults-debian.conf
fi
echo -e "[sshd]\nenabled = true" > /etc/fail2ban/jail.d/sshd.conf
systemctl restart fail2ban
