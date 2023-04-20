# proxmox

all about proxmox installation and configuration

## Index

0. [prerequisites](#prerequisites)  
   0.1 [BIOS options](#bios)
1. [installation](#installation)
2. [configuration (console)](#configuration)  
   2.1 [first steps](#first_steps)  
   2.2 [install usefull tools](#tools)  
   2.3 [setup ntp server](#ntp)  
   2.4 [setup dns server](#dns)  
   2.5 [remove subscription notice](#subscription_notice)  
   2.6 [install kernel-headers](#kernel-headers)  
   2.7 [change kernel boot version](#kernel-boot)  
   2.8 [enable iommu for pcie passthrough](#iommu)
3. [usage](#usage)  
   3.1 [browse](#browse)
4. [errors](#errors)  
   4.1 [network won't start after reboot](#error_network)  
   4.2 [bluetooth errors](#error_bluetooth)  
   4.3 [sound errors](#error_sound)  
   4.4 [zfs errors](#error_zfs)  
   4.5 [kvm: exiting hardware virtualization](#error_kvm)  
   4.6 [no network after update](#error_network_update)  
   4.100 [(LXC) slow boot times](#lxc_slow_boot)
5. [update pve](#update_pve)
6. [resize container](#resize_container)
7. [port mirror](#port_mirror)

\# [Find Me](#findme)  
\# [License](#license)

# 1. installation <a name="installation"></a>

**see official documentation on [pve.proxmox.com](https://pve.proxmox.com/pve-docs/pve-admin-guide.html)**

# 2. configuration <a name="configuration"></a>

**login via ssh (port 22) or do the steps nativ with a keyboard**

### 2.1 first steps <a name="first_steps"></a>

**install pve-no-subscription repository**
**skip this step if you have an enterprise subscription**

```shell
rm -f /etc/apt/sources.list.d/pve-enterprise.list
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/apt/sources.list.d/pve-no-subscription.list -O /etc/apt/sources.list.d/pve-no-subscription.list

```

**update packages**

```shell
apt update && apt upgrade -y

```

### 2.2 install usefull tools <a name="tools"></a>

**install pve-no-subscription repository**

```shell
apt install htop iperf iperf3 ncdu ntpdate rfkill

```

### 2.3 setup ntp server <a name="ntp"></a>

**change /etc/chrony/chrony.conf**

```shell
...
# Use Debian vendor zone.
# pool 2.debian.pool.ntp.org iburst
server 0.de.pool.ntp.org iburst
server 1.de.pool.ntp.org iburst
server 2.de.pool.ntp.org iburst
...

```

**restart chrony**

```shell
systemctl restart chronyd

```

### 2.4 setup dns server <a name="dns"></a>

**change /etc/resolv.conf**

```shell
search local.net
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111

```

### 2.5 remove subscription notice <a name="subscription_notice"></a>

**need to be done after every update from pve!**

**remove the notice and restart the proxmox service**

```shell
cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

```

**revert the changes if something went wrong**

```shell
cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
systemctl restart pveproxy.service

```

### 2.6 install kernel-headers <a name="kernel-headers"></a>

**the kernel-headers should match with your kernel version!!!**

```shell
apt install pve-headers-5.15 pve-headers-5.15.35-2-pve

```

### 2.7 change kernel boot version <a name="kernel-boot"></a>

**change which kernel should boot**

```shell
proxmox-boot-tool kernel list
proxmox-boot-tool kernel add 5.15.35-2-pve
# proxmox-boot-tool kernel remove <old-kernel-version>-pve
proxmox-boot-tool refresh

```

### 2.8 enable iommu for pcie passthrough <a name="iommu"></a>

**follow instructions on [proxmox.com/wiki](https://pve.proxmox.com/wiki/Pci_passthrough)**
**and [thomas-krenn.com](https://www.thomas-krenn.com/de/wiki/Proxmox_PCIe_Passthrough_aktivieren)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**Backend**  
[https://proxmox.ip:8006/](https://proxmox.ip:8006)

# 4. errors <a name="errors"></a>

### 4.1 network won't start after reboot <a name="error_network"></a>

```shell
systemctl mask ifupdown-pre.service
systemctl mask ifupdown2-pre.service
systemctl mask systemd-udev-settle.service

```

### 4.2 bluetooth errors <a name="error_bluetooth"></a>

**dmesg error on boot**

```shell
...
[    3.080602] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin failed with error -2
[    3.081688] Bluetooth: hci0: Failed to load firmware file (-2)
...
[   13.102071] Bluetooth: hci0: Execution of wmt command timed out
[   13.102128] Bluetooth: hci0: Failed to send wmt func ctrl (-110)
[   15.917971] usb 5-4: Failed to suspend device, error -110
...
```

**disable bluetooth**

```shell
echo "blacklist btusb" > /etc/modprobe.d/bluetooth.conf
echo "blacklist btrtl" >> /etc/modprobe.d/bluetooth.conf
echo "blacklist btbcm" >> /etc/modprobe.d/bluetooth.conf
echo "blacklist btintel" >> /etc/modprobe.d/bluetooth.conf
echo "blacklist bluetooth" >> /etc/modprobe.d/bluetooth.conf

```

### 4.3 sound errors <a name="error_sound"></a>

**dmesg error on boot**

```shell
...
[    3.082545] snd_hda_intel 0000:06:00.6: no codecs found!
...
```

**disable sound**

```shell
echo "blacklist btusb" > /etc/modprobe.d/bluetooth.conf

```

### 4.4 zfs errors <a name="error_zfs"></a>

**dmesg error on boot**

```shell
...
[DEPEND] Dependency failed for Import ZFS pools by cache file
[DEPEND] Dependency failed for Import ZFS pools by device scanning.
...
```

**disable service**

```shell
systemctl disable zfs-import-cache.service
systemctl disable zfs-import-scan

```

### 4.5 kvm: exiting hardware virtualization <a name="error_kvm"></a>

**install latest kernel + kernel-headers**

```shell
apt install pve-kernel-5.15 pve-kernel-5.15.35-2-pve pve-headers-5.15.35-2-pve pve-headrs-5.15

```

### 4.6 no network after update <a name="error_network_update"></a>

**you probably updated your kernel but forgot to install kernel-headers**

```shell
apt install pve-kernel-5.15.12-1-pve

```

### 4.99 prevent /etc/network/interfaces inside VM/LXC from overwrite <a name="interfaces_overwrite"></a>

**if your /etc/network/interfaces inside a VM/LXC gets overwritten by proxmox, do inside your VM/LXC:**

```shell
touch /etc/network/.pve-ignore.interfaces

```

### 4.100 (LXC) slow boot times <a name="lxc_slow_boot"></a>

**if your LXC Container boots only in about 4-5 mins -> switch IPv6 from DHCP to SLAAC**

# 5. update pve <a name="update_pve"></a>

**DO NOT just simple apt update && apt upgrade -y**  
**you will run into error 4.6! if the kernel will be updated!**  
**you need to install the new pve-headers before updating your kernel!**

```shell
apt update && apt upgrade
# abort here with CTRL-C
# check if the kernel will be updated
# remember the new kernel version
# apt install pve-headers-<enter new kernel version here>-pve
apt install pve-headers-5.15.35-2-pve
apt update && apt upgrade -y
# now you need to change the kernel boot version (see 2.7)
proxmox-boot-tool kernel list
# check which kernel is listet under Manually selected kernels:
proxmox-boot-tool kernel add <new-kernel-version>-pve
# for example:
#  proxmox-boot-tool kernel add 5.15.35-2-pve
proxmox-boot-tool kernel remove <old-kernel-version>-pve
# for example:
#  proxmox-boot-tool kernel remove 5.15.35-1-pve
proxmox-boot-tool refresh

```

# 6. resize container <a name="resize_container"></a>

**VMID: 110**  
**size: 1T**

```shell
# get VMID from your container (e.g.: 110):
pct list

# stop the vm
pct stop 110

# resize vm
# pct resize <VMID> <disk> <size>
pct resize 110 rootfs 1T

# DONE!
# -----

# To do it by hand:

# get the path of the container disk (e.g.: /dev/pve/vm-110-disk-0):
lvdisplay | grep "LV Path\|LV Size"

# check the disk first
# e2fsck -f <disk>
e2fsck -f /dev/pve/vm-210-disk-0

# resize the disk
# resize2fs <disk> <size>
resize2fs /dev/pve/vm-210-disk-0 1T

# extend/reduce the LV size
# lvreduce -L <size> <path>
# lvextend -L <size> <path>
lvextend -L 1T /dev/pve/vm-210-disk-0

# check if the size has changed in the container config file:
vi /etc/pve/lxc/110.conf
# rootfs: local-lvm:vm-110-disk-0,size=1T

# start the vm
pct start 110

```

# 7. port mirror <a name="port_mirror"></a>

**see [codingpackets.com/blog/proxmox-vm-bridge-port-mirror](https://codingpackets.com/blog/proxmox-vm-bridge-port-mirror/)**

**7.1 install openvswitch-switch**

```shell
apt install openvswitch-switch wget

```

**7.2 create /opt/scripts/network/mirror_ports.sh script**

```shell
mkdir -p /var/lib/vz/snippets/
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/var/lib/vz/snippets/port-mirror.sh -O /var/lib/vz/snippets/port-mirror.sh
chmod +x /var/lib/vz/snippets/port-mirror.sh

```

**7.3 apply script to vm/lxc container**

```shell
# for lxc container id 100
pct set 100 --hookscript local:snippets/port-mirror.sh

# for vm id 100
qm set 100 --hookscript local:snippets/port-mirror.sh
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
