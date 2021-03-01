#!/bin/bash
# VBoxGuestTools: attach virtualbox guest tools to /dev/cdrom
read -n 1 -s -r -p "Attach virtualbox guest tools -> then press any key to continue ..."
apt update && apt upgrade -y
apt install \
        build-essential \
        dkms \
        linux-headers-$(uname -r) \
        -y
mount /dev/cdrom /mnt
/mnt/VBoxLinuxAdditions.run
umount /mnt
