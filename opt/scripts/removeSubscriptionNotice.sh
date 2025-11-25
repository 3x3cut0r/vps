#!/bin/bash
# Remove proxmox subscription notice after login
cp /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js.bak
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
