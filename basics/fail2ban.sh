#!/bin/bash
apt install fail2ban -y
if [ $(cat /etc/fail2ban/jail.d/defaults-debian.conf | grep sshd) = "[sshd]" ]; then
    echo "remove /etc/fail2ban/jail.d/defaults-debian.conf"
    rm /etc/fail2ban/jail.d/defaults-debian.conf
fi
echo "create /etc/fail2ban/jail.d/sshd.conf"
echo -e "[sshd]\nenabled = true" > /etc/fail2ban/jail.d/sshd.conf
echo "systemctl restart fail2ban"
systemctl restart fail2ban
fail2ban-client status
