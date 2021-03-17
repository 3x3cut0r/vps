#!/bin/bash
apt install fail2ban ipset -y
if [ $(cat /etc/fail2ban/jail.d/defaults-debian.conf | grep sshd) = "[sshd]" ]; then
    echo "remove /etc/fail2ban/jail.d/defaults-debian.conf"
    rm /etc/fail2ban/jail.d/defaults-debian.conf
fi
echo "create /etc/fail2ban/jail.d/sshd.conf"
echo "[sshd]" > /etc/fail2ban/jail.d/sshd.conf
echo "enabled   = true" >> /etc/fail2ban/jail.d/sshd.conf
echo "port      = ssh" >> /etc/fail2ban/jail.d/sshd.conf
echo "filter    = sshd[mode=aggressive]" >> /etc/fail2ban/jail.d/sshd.conf
echo "logpath   = /var/log/auth.log" >> /etc/fail2ban/jail.d/sshd.conf
echo "banaction = iptables-ipset-proto6" >> /etc/fail2ban/jail.d/sshd.conf
echo "maxretry  = 5" >> /etc/fail2ban/jail.d/sshd.conf
echo "findtime  = 1h" >> /etc/fail2ban/jail.d/sshd.conf
echo "bantime   = 2w" >> /etc/fail2ban/jail.d/sshd.conf
echo "ignoreip  = 127.0.0.1/8" >> /etc/fail2ban/jail.d/sshd.conf
echo "systemctl restart fail2ban"
systemctl restart fail2ban
fail2ban-client status
