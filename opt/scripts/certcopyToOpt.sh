#!/bin/bash
CERT=/opt/docker/volumes/nginx-proxy-manager-letsencrypt/_data/live/npm-1/cert.pem
PRIVKEY=/opt/docker/volumes/nginx-proxy-manager-letsencrypt/_data/live/npm-1/privkey.pem
CHAIN=/opt/docker/volumes/nginx-proxy-manager-letsencrypt/_data/live/npm-1/chain.pem
FULLCHAIN=/opt/docker/volumes/nginx-proxy-manager-letsencrypt/_data/live/npm-1/fullchain.pem
DHPARAM=/opt/docker/config-files/nginx-proxy-manager/dhparam.pem

CERT_PATH=/opt/certs

USER=certcopy

mkdir -p $CERT_PATH && \
\
cp $CERT $CERT_PATH/cert.pem && \
cp $PRIVKEY $CERT_PATH/privkey.pem && \
cp $FULLCHAIN $CERT_PATH/fullchain.pem && \
cp $CHAIN $CERT_PATH/chain.pem && \
cp $DHPARAM $CERT_PATH && \
\
chmod 644 $CERT_PATH/* && \
chown $USER:$USER $CERT_PATH/*
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
