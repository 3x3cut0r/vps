#!/bin/bash
wg syncconf wg0 <(wg-quick strip wg0)
RETURN=$?

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ $RETURN -eq 0 ]; then
  echo -e "${GREEN}wireguard reloaded successfully${NC}"
else
  echo -e "${RED}error: $RETURN${NC}"
fi