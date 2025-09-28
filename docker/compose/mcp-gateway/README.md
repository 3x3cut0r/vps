# mcp-gateway

**docker-compose.yml for mcp-gateway - mcp-gateway is a ...**

## Index

1. [prerequisites](#prerequisites)
2. [deploy docker-compose.yml](#deploy)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**install golang-go >= 1.23**

```shell
GO_VERSION=1.24.4
cd /usr/local
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# Go ins PATH bringen
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

go version
```

**install docker-mcp CLI**

```shell
# Install as Docker CLI plugin on your docker host
cd /opt/docker
git clone https://github.com/docker/mcp-gateway.git
cd mcp-gateway
mkdir -p "$HOME/.docker/cli-plugins"
apt install make
make docker-mcp                      # builds ~/.docker/cli-plugins/docker-mcp
docker mcp --help

```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/mcp-gateway/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/mcp-gateway/docker-compose.yml)**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
