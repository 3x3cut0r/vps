#!/bin/bash
# generate ssh key-pair
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa

# copy certcopy key to host
ssh-copy-id certcopy@192.168.40.110

# copy certs to host
/opt/scripts/certcopyFromHost.sh

# remove self
rm -- "$0"