# pihole

pihole installation inside a unprivileged LXC-Container

## Index

1. [create LXC-Container](#lxc-container)  
2. [installation](#installation)  
  2.1 [prerequisites](#prerequisites)  
  2.2 [installation](#installation)  
  2.3 [change pihole password](#pihole_password)  
  2.4 [cloudflare DNS over HTTPS](#cloudflare_doh)  
3. [configuration](#configuration)  
  3.1 [add groups](#add_groups)  
  3.2 [add lists](#add_lists)  
4. [usage](#usage)  
  4.1 [browse](#browse)  
5. [errors](#errors)  
  5.1 [installation error](#error_installation)  
\# [Find Me](#findme)  
\# [License](#license)  

# 1. create LXC-Container <a name="lxc-container"></a>  
**create a LXC-Container:**  
- unprivileged = 1  
- nesting = 1  
- template = debian-11-standard  
- disk-space = 30GiB  
- cpu-cores = 1  
- ram = 512 MiB  
- swap = 0 MiB  
- IPv4 = static (set ip + gw)  
- IPv6 = SLAAC  
- dns-domain = local.lan  
- dns-server = 1.1.1.1  

# 2. installation <a name="installation"></a>  

### 2.1 prerequisites <a name="prerequisites"></a>  
```shell
apt update && apt upgrade -y
apt install curl -y

```

### 2.2 installation <a name="installation"></a>  
```shell
curl -sSL https://install.pi-hole.net | bash
chown -R pihole:pihole /etc/pihole

```

### 2.3 change pihole password <a name="pihole_password"></a>  
```shell
pihole -a -p

```

### 2.4 cloudflare DNS over HTTPS <a name="cloudflare_doh"></a>  
```shell
cd /usr/local/bin
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
mv cloudflared-linux-amd64 cloudflared
sudo useradd -s /usr/sbin/nologin -r -M cloudflared
echo -e "# Commandline args for cloudflared" > /etc/default/cloudflared
echo -e "CLOUDFLARED_OPTS=--port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query" >> /etc/default/cloudflared
sudo chmod +x /usr/local/bin/cloudflared
sudo chown cloudflared:cloudflared /etc/default/cloudflared
sudo chown cloudflared:cloudflared /usr/local/bin/cloudflared
wget https://raw.githubusercontent.com/3x3cut0r/proxmox/main/lxc/pihole/lib/systemd/system/cloudflared.service -O /lib/systemd/system/cloudflared.service
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
sudo systemctl status cloudflared

```

**test dns**  
```shell
dig @127.0.0.1 -p 5053 google.com

```

# 3. configuration <a name="configuration"></a>  
**list tables**  
```shell
sudo sqlite3 /etc/pihole/gravity.db .tables

```

### 3.1 add groups <a name="add_groups"></a>  
**groups for [blocklistproject](https://github.com/blocklistproject/Lists)**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (100, 1, 'Abuse', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (101, 1, 'Ads', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (102, 1, 'Basic', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (103, 1, 'Crypto', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (104, 1, 'Drugs', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (105, 1, 'Facebook', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (106, 1, 'Fraud', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (107, 1, 'Gambling', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (108, 1, 'Malware', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (109, 1, 'Phishing', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (110, 1, 'Piracy', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (111, 1, 'Porn', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (112, 1, 'Ransomware', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (113, 1, 'Redirect', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (114, 1, 'Scam', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (115, 1, 'Smart-TV', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (116, 1, 'Tiktok', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (117, 1, 'Torrent', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (118, 1, 'Tracking', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (119, 1, 'Twitter', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (120, 1, 'Vaping', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (121, 1, 'Whatsapp', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (122, 1, 'Youtube', 'BlockListProject');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (199, 1, 'Everything', 'BlockListProject');"

```
**groups for [firebog](https://firebog.net/)**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (200, 1, 'All_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (201, 1, 'All_Tick_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (202, 1, 'All_Tick_Nocross_Cross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (210, 1, 'Advertising_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (211, 1, 'Suspicious_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (212, 1, 'Malicious_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (213, 1, 'Tracking_and_Telemetry_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (214, 1, 'Other_Tick', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (215, 1, 'Advertising_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (216, 1, 'Suspicious_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (217, 1, 'Malicious_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (218, 1, 'Tracking_and_Telemetry_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (219, 1, 'Other_Nocross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (220, 1, 'Advertising_Cross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (221, 1, 'Suspicious_Cross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (222, 1, 'Malicious_Cross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (223, 1, 'Tracking_and_Telemetry_Cross', 'Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (224, 1, 'Other_Cross', 'Firebog');"

```

**groups for 3x3cut0r's lists**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO 'group' (id, enabled, name, description) VALUES (330, 1, 'Filehoster Whitelists', '3x3cut0r');"

```

### 3.2 add lists <a name="add_lists"></a>  
**adlists from [blocklistproject](https://github.com/blocklistproject/Lists)**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (100, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/abuse.txt', 1, 'Abuse (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (101, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/ads.txt', 1, 'Ads (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (102, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/basic.txt', 1, 'Basic (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (103, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/crypto.txt', 1, 'Crypto (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (104, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/drugs.txt', 1, 'Drugs (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (105, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/facebook.txt', 1, 'Facebook (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (106, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/fraud.txt', 1, 'Fraud (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (107, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/gambling.txt', 1, 'Gambling (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (108, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/malware.txt', 1, 'Malware (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (109, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/phishing.txt', 1, 'Phishing (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (110, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/piracy.txt', 1, 'Piracy (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (111, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/porn.txt', 1, 'Porn (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (112, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/ransomware.txt', 1, 'Ransomware (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (113, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/redirect.txt', 1, 'Redirect (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (114, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/scam.txt', 1, 'Scam (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (115, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/smart-tv.txt', 1, 'Smart-TV (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (116, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/tiktok.txt', 1, 'Tiktok (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (117, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/torrent.txt', 1, 'Torrent (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (118, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/tracking.txt', 1, 'Tracking (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (119, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/twitter.txt', 1, 'Twitter (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (120, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/vaping.txt', 1, 'Vaping (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (121, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/whatsapp.txt', 1, 'Whatsapp (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (122, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/youtube.txt', 1, 'Youtube (BlockListProject)');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (199, 'https://raw.githubusercontent.com/blocklistproject/Lists/master/everything.txt', 1, 'Everything (BlockListProject)');"
pihole -g

```
**adlists from [blocklistproject](https://firebog.net/)**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (200, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_tick.list', 1, 'All_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (201, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_nocross.list', 1, 'All_Tick_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (202, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_all.list', 1, 'All_Tick_Nocross_Cross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (210, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_advertising_tick.list', 1, 'Advertising_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (211, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_suspicious_tick.list', 1, 'Suspicious_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (212, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_malicious_tick.list', 1, 'Malicious_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (213, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_tracking_and_telemetry_tick.list', 1, 'Tracking & Telemetry_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (214, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_other_tick.list', 1, 'Other_Tick_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (215, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_advertising_nocross.list', 1, 'Advertising_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (216, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_suspicious_nocross.list', 1, 'Suspicious_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (217, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_malicious_nocross.list', 1, 'Malicious_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (218, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_tracking_and_telemetry_nocross.list', 1, 'Tracking _and_Telemetry_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (219, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_other_nocross.list', 1, 'Other_Nocross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (220, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_advertising_cross.list', 1, 'Advertising_Cross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (221, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_suspicious_cross.list', 1, 'Suspicious_Cross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (222, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_malicious_cross.list', 1, 'Malicious_Cross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (223, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_tracking_and_telemetry_cross.list', 1, 'Tracking & Telemetry_Cross_Firebog');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (id, address, enabled, comment) VALUES (224, 'https://raw.githubusercontent.com/3x3cut0r/pihole/main/blacklists/firebog_other_cross.list', 1, 'Other_Cross_Firebog');"
pihole -g

```

### 3.3 update adlist_by_group <a name="update_adlists_by_group"></a>  
**assign blacklistproject lists to groups**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=100 WHERE adlist_id=100;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=101 WHERE adlist_id=101;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=102 WHERE adlist_id=102;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=103 WHERE adlist_id=103;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=104 WHERE adlist_id=104;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=105 WHERE adlist_id=105;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=106 WHERE adlist_id=106;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=107 WHERE adlist_id=107;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=108 WHERE adlist_id=108;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=109 WHERE adlist_id=109;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=110 WHERE adlist_id=110;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=111 WHERE adlist_id=111;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=112 WHERE adlist_id=112;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=113 WHERE adlist_id=113;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=114 WHERE adlist_id=114;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=115 WHERE adlist_id=115;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=116 WHERE adlist_id=116;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=117 WHERE adlist_id=117;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=118 WHERE adlist_id=118;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=119 WHERE adlist_id=119;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=120 WHERE adlist_id=120;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=121 WHERE adlist_id=121;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=122 WHERE adlist_id=122;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=199 WHERE adlist_id=199;"

```

**assign firebog lists to groups**  
```shell
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=200 WHERE adlist_id=200;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=201 WHERE adlist_id=201;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=202 WHERE adlist_id=202;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=210 WHERE adlist_id=210;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=211 WHERE adlist_id=211;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=212 WHERE adlist_id=212;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=213 WHERE adlist_id=213;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=214 WHERE adlist_id=214;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=215 WHERE adlist_id=215;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=216 WHERE adlist_id=216;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=217 WHERE adlist_id=217;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=218 WHERE adlist_id=218;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=219 WHERE adlist_id=219;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=220 WHERE adlist_id=220;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=221 WHERE adlist_id=221;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=222 WHERE adlist_id=222;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=223 WHERE adlist_id=223;"
sudo sqlite3 /etc/pihole/gravity.db "UPDATE adlist_by_group SET group_id=224 WHERE adlist_id=224;"

```

# 4. usage <a name="usage"></a>  

### 4.1 browse <a name="browse"></a>  
**Backend**  
[https://pihole.ip/admin](https://pihole.ip/admin)  

# 5. errors <a name="errors"></a>  

### 5.1 installation error <a name="error_installation"></a>  
**[✗] Unable to build gravity tree in /etc/pihole/gravity.db_temp**  
**Error: no such table: main.gravity**  
```shell
sudo rm /etc/pihole/gravity.db
pihole -r

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
