#!/bin/bash
apt install     curl \
                linux-headers-$(uname -r) \
                nano \
                openssh-server \
                sudo \
                vim \
                wget \
                -y
