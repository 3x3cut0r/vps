# splunk

**docker-compose.yml for splunk - a platform for searching, monitoring, and analyzing machine-generated big data**

## Index

1. [deploy docker-compose.yml](#deploy)
2. [usage](#usage)  
   2.1 [browse](#browse)
3. [configuration](#configuration)

\# [Find Me](#findme)  
\# [License](#license)

# 1. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/splunk/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/splunk/docker-compose.yml)**

# 2. usage <a name="usage"></a>

### 2.1 browse <a name="browse"></a>

**Frontend**  
[https://splunk.3x3cut0r.de](https://splunk.3x3cut0r.de)

# 3. configuration <a name="configuration"></a>

**Initial setup:**
1. Login with admin and set `SPLUNK_PASSWORD` and create new admin user
2. Enter/change license-group and add license
3. Create a splunk account on https://www.splunk.com

**Install Snort 3 JSON Alerts app:**
1. Install app: "Snort 3 JSON Alerts" (requires splunk.com account)

**Configure Snort 3 JSON Alerts app:**
```shell
sudo mkdir /opt/splunk/etc/apps/TA_Snort3_json/local
sudo touch /opt/splunk/etc/apps/TA_Snort3_json/local/inputs.conf
sudo vi /opt/splunk/etc/apps/TA_Snort3_json/local/inputs.conf
```

**inputs.conf:**
```shell
[monitor:///var/log/snort/*alert_json.txt*]
sourcetype = snort3:alert:json
```

**Restart splunk**

**Search examples:**
```shell
sourcetype="snort3:alert:json"
```

**Show count of all events by message:**
```shell
sourcetype="snort3:alert:json"
| stats count by msg
| sort by count desc
```

**Show all event sources on a map:**
```shell
sourcetype="snort3:alert:json"
| iplocation src_addr
| stats count by Country
| geom geo_countries featureIdField="Country"
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
