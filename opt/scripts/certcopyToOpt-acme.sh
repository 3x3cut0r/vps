#!/bin/bash
CERT=/root/.acme.sh/3x3cut0r.de_ecc/3x3cut0r.de.cer
PRIVKEY=/root/.acme.sh/3x3cut0r.de_ecc/3x3cut0r.de.key
FULLCHAIN=/root/.acme.sh/3x3cut0r.de_ecc/fullchain.cer
CA=/root/.acme.sh/3x3cut0r.de_ecc/ca.cer
DHPARAM=/etc/ssl/dhparam.pem

CERT_PATH=/opt/certs

USER=certcopy

mkdir -p $CERT_PATH && \
\
cp $CERT $CERT_PATH/cert.pem && \
cp $PRIVKEY $CERT_PATH/privkey.pem && \
cp $FULLCHAIN $CERT_PATH/fullchain.pem && \
cp $CA $CERT_PATH/ca.pem && \
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
