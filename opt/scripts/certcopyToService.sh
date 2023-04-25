#!/bin/bash

# stop mailcow-dockerized 
cd /var/mailcow-dockerized/
docker compose down

# wait until mailcow-dockerized stack is down
while [[ $(docker ps --filter "label=com.docker.compose.project=mailcowdockerized" -q) ]]; do
    sleep 1
done

# copy certs to mailcow-dockerized 
cp -Lr /opt/certs/fullchain.pem /var/mailcow-dockerized/data/assets/ssl/cert.pem
cp -Lr /opt/certs/privkey.pem   /var/mailcow-dockerized/data/assets/ssl/key.pem
cp -Lr /opt/certs/dhparam.pem   /var/mailcow-dockerized/data/assets/ssl/dhparams.pem
chown root:root /var/mailcow-dockerized/data/assets/ssl/*.pem
chmod 644 /var/mailcow-dockerized/data/assets/ssl/*.pem

# start mailcow-dockerized 
docker compose up -d
RETURN=$?

# setup colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# print success
if [ $RETURN -eq 0 ]; then
  echo -e "${GREEN}success${NC}"
else
  echo -e "${RED}error: $RETURN${NC}"
fi
