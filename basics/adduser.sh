#!/bin/bash
USERNAME=""
if [ "$1" ]; then
    USERNAME="$1"
fi
adduser $USERNAME

# add to sudo group:
read -p "Do you want to add $USERNAME to sudo group? (y/N): "
if [[ $REPLY =~ ^[Yy]$ ]]; then
    usermod -aG sudo $USERNAME
fi
