# ssh

howto login with ssh via openssl public/private key

## Index

1. [host configuration](#host)
2. [client configuration](#client)

\# [Find Me](#findme)  
\# [License](#license)

# 1. host configuration <a name="host"></a>

**Optional: create user (if you don't want to share root permissions)**

```shell
SSH_USER=sshuser
SSH_USER_HOME=/home/certcopy
SSH_USER_ID=10022
SSH_GROUP_ID=10022

addgroup --gid $SSH_GROUP_ID $SSH_USER

mkdir -p $SSH_USER_HOME

adduser \
  --gecos "" \
  --home $SSH_USER_HOME \
  --no-create-home \
  --disabled-login \
  --disabled-password \
  --shell /bin/bash \
  --uid $SSH_USER_ID \
  --gid $SSH_GROUP_ID \
  $SSH_USER

chown $SSH_USER:$SSH_USER $SSH_USER_HOME

su $SSH_USER

cd ~
```

**generate public/private key**

```shell
ssh-keygen -t rsa -b 4096
```

# 2. client configuration <a name="client"></a>

**generate public/private-key**
**and copy public-key to hosts authorized_keys**

```shell
ssh-keygen -t rsa -b 4096
ssh-copy-id <SSH_USER>@<HOST_IP>
# <enter SSH_USER password>

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
