#!/bin/bash
###################
# prerequisites   #
###################
#
# ON nginx (where the certificates are located):
#
# 1. create certcopy group:
#    addgroup --gid 10022 certcopy
#   
# 2. create certcopy user:
#    adduser \
#	     --gecos "" \
#      --home /home/certcopy \
#	     --no-create-home \
#	     --disabled-login \
#	     --disabled-password \
#	     --shell /bin/bash \
#	     --uid 10022 \
#	     --gid 10022 \
#	     certcopy
# 
# 3. change permissions
#    chown certcopy:certcopy /home/certcopy
#
# 4. generate ssh public/privatekey with certcopy user
#    su certcopy
#    cd /home/certcopy
#    ssh-keygen -t rsa -b 4096
#
# ON your client (host) (where you copy the certificates to):
#
# 1. generate ssh public/privatekey with root
#    ssh-keygen -t rsa -b 4096
#
# 2. copy the client public certificate to authorized_keys on nginx
#    ssh-copy-id <user>@<nginx_ip>
#    <enter user password>
#

# copy from
PROXMOX_HOST=192.168.40.110
PROXMOX_USER=certcopy

# copy to
CERTS=/opt/certs
mkdir -p $CERTS && \
\
scp $PROXMOX_USER@$PROXMOX_HOST:/opt/certs/* $CERTS && chmod 644 /opt/certs/*
RETURN=$?

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ $RETURN -eq 0 ]; then
  echo -e "${GREEN}success${NC}"
else
  echo -e "${RED}error: $RETURN${NC}"
fi
