# acme configuration

installation of acme for lets encrypt certificates

## Index

1. [installation](#installation)
2. [configuration](#configuration)
3. [issue cert](#issue)
4. [set systemd timer for renewal](#systemd_timer)

\# [Find Me](#findme)  
\# [License](#license)

# 1. installation <a name="installation"></a>

**see [official docs for acme.sh](https://github.com/acmesh-official/acme.sh)**

```shell
cd ~
git clone https://github.com/acmesh-official/acme.sh.git
cd ./acme.sh
./acme.sh --install -m executor55@gmx.de
./acme.sh --upgrade --auto-upgrade
```

# 2. configuration <a name="configuration"></a>

**set dns provider specific API information**  
**for more information see: [acme.sh wiki](https://github.com/acmesh-official/acme.sh/wiki/dnsapi)**  
**Example for the Netcup API:**

```shell
export NC_Apikey="<API-Key>"
export NC_Apipw="<API-Password>"
export NC_CID="<Customer-ID>"
```

**after the cert is issued ... the account information will be stored in:**

```shell
~/.acme.sh/account.conf
```

# 3. issue cert <a name="issue"></a>

```shell
acme.sh --issue \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --email executor55@gmx.de \
  --home ~/.acme.sh \
  --keylength ec-256 \
  --dns dns_netcup \
  --dnssleep 660 \
  --reloadcmd "systemctl reload nginx" \
  --domain 3x3cut0r.de \
  --domain '*.3x3cut0r.de'
```

# 4. set systemd timer for renewal <a name="systemd_timer"></a>

**copy service and timer to:**

```shell
/lib/systemd/system
```

**see [acme-renewal.service]()**  
**see [acme-renewal.timer]()**

```shell
sudo systemctl daemon-reload
sudo systemctl start acme-renewal --now
sudo systemctl enable acme-renewal.timer
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
