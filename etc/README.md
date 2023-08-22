# setup dns inside lxc container

```shell
# use default dns
rm /etc/resolv.conf
touch /etc/resolv.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf
apt update && apt upgrade -y
apt autoremove -y

# install systemd-resolved
apt install systemd-resolved -y

# prevent resolv.conf from being overwritten
rm /etc/resolv.conf
touch /etc/.pve-ignore.resolv.conf
ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# change dns server from systemd-resolved
sed -i 's/#DNS=/DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001/g' /etc/systemd/resolved.conf
sed -i 's/#FallbackDNS=/FallbackDNS=8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844/g' /etc/systemd/resolved.conf
sed -i 's/#Domains=/Domains=~./g' /etc/systemd/resolved.conf
sed -i 's/#DNSOverTLS=no/DNSOverTLS=opportunistic/g' /etc/systemd/resolved.conf

# enable and restart systemd-resolved
systemctl enable systemd-resolved
systemctl restart systemd-resolved

resolvectl status

```
