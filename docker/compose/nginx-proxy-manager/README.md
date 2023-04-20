# nginx-proxy-manager

**docker-compose.yml for nginx-proxy-manager**

## Index

1. [download custom folder to your harddrive](#custom)
2. [generate dhparam.pem](#dhparam)
3. [deploy / docker-compose.yml](#deploy)
4. [configure npm initial via port 81](#port81)
5. [configure lets encrypt](#le)
6. [add npm proxy host](#proxy_host)
7. [browse and configure npm secure](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. download custom folder to your harddrive <a name="custom"></a>

**the proxy.conf and server_proxy.conf will secure your nginx. use at your own risk!**  
**step 1 can be skipped, but then you have to remove the volume mappings from the docker-compose.yml too!**

```shell
mkdir -p /opt/docker/config-files/nginx-proxy-manager/custom
cd /opt/docker/config-files/nginx-proxy-manager/custom
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/nginx-proxy-manager/custom/proxy.conf
wget https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/nginx-proxy-manager/custom/server_proxy.conf

```

# 2. generate dhparam.pem <a name="dhparam"></a>

```shell
mkdir -p /opt/docker/config-files/nginx-proxy-manager
cd /opt/docker/config-files/nginx-proxy-manager
apt install openssl
openssl dhparam -out dhparam.pem 4096

```

# 3. deploy / docker-compose.yml <a name="deploy"></a>

**[see docker/compose/nginx-proxy-manager/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/nginx-proxy-manager/docker-compose.yml)**

# 4. configure npm initial via port 81 <a name="port81"></a>

# 5. configure lets encrypt <a name="le"></a>

**5.1. browse SSL Certificates**  
**5.2. Add SSL Certificate -> Let's Encryp**  
**5.3. configure your wildcard certificate and click Save**

# 6. add npm proxy host <a name="proxy_host"></a>

**6.1. browse Hosts -> Proxy Hosts**  
**6.2. Add Proxy Host**

**6.3 Example on npm.3x3cut0r.de:**  
**Domain Name: npm.3x3cut0r.de**  
**Scheme: http**  
**Forwarded Host: <Private IP of your npm (Host or LXC or VM or ...)>**  
**Forwarded Port: <Port of your npm (80)>**  
**Almost ever enable Websockets Support!**
**SSL: Select your created Certificate**  
**SSL: enable Force SSL**  
**SSL: enable HTTP2 Support**  
**SSL: enable HSTS**  
**Save**

**6.4 For more security you can add this lines in**  
**Advanced/Custom Nginx Configuration for each proxy host:**

```shell
add_header Referrer-Policy                      "no-referrer"   always;
add_header X-Download-Options                   "noopen"        always;
add_header X-Permitted-Cross-Domain-Policies    "none"          always;
add_header X-Robots-Tag                         "none"          always;
```

**Services where you should avoid step 6.4, because it will breake functionality:**

```shell
bigbluebutton
mautrix-wsproxy
nextcloud
pgadmin
rocketchat
synapse
```

# 7. browse and configure npm secure <a name="browse"></a>

[https://npm.3x3cut0r.de](https://npm.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
