#!/bin/bash
INTERFACE=$1
if [ -z "$INTERFACE" ]; then
    read -p "enter interface to restart (vmbr0): "
    if [ ! -z $REPLY ]; then
        INTERFACE=$REPLY
    else
        INTERFACE=vmbr0
    fi
fi
ifdown $INTERFACE && sleep 3 && ifup $INTERFACE
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