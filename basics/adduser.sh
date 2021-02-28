#!/bin/bash
USERNAME=""
USERID=""
if [ "$1" ]; then
    USERNAME="$1"
else
    # username
    read -p "username: "
    if [ ! -z $REPLY ]; then USERNAME=$REPLY; fi
fi
ARGS=""
# uid/gid
read -p "set uid/gid: (empty = generated): "
if [ ! -z $REPLY ]; then USERID=$REPLY; ARGS="--uid $USERID --gid $USERID"; fi

# check if username in group
if grep -q $USERNAME /etc/group; then
    echo "$USERNAME already exists in /etc/group"
    exit 1
elif grep -q $USERID /etc/group; then
    echo "$USERID already exists in /etc/group"
    exit 1
fi

# shell
read -p "set shell? (/bin/bash): "
if [ ! -z $REPLY ]; then ARGS="$ARGS --shell $REPLY"; else ARGS="$ARGS --shell /bin/bash"; fi
# disable password
read -p "disable password? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then ARGS="$ARGS --disabled-password"; fi
# disable login
read -p "disable login? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then ARGS="$ARGS --disabled-login"; fi
# no create home
read -p "create no home? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then ARGS="$ARGS --no-create-home"; fi
# gecos
read -p "set gecos? (''): "
if [ ! -z $REPLY ]; then ARGS="$ARGS --gecos $REPLY"; fi

# addgroup
addgroup --gid $USERID $USERNAME

# adduser
adduser $ARGS $USERNAME

# add to sudo group:
read -p "Do you want to add $USERNAME to sudo group? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    usermod -aG sudo $USERNAME
fi
