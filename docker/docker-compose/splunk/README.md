# Splunk

# 1. deploy docker-compose.yml

# 2. setup nginx reverse proxy

# 3. login with admin and set SPLUNK_PASSWORD and create new (admin-)user

# 4. enter/change license-group and add license

# 5. create a splunk account on https://www.splunk.com

# 6. install app: "Snort 3 JSON Alerts" (you will need a splunk.com account)

# 7. configure "Snort 3 JSON Alerts"-app:
**do this inside your container (docker container exec ...**  
**or in your splunk-conf volume on your host**  
```shell
sudo mkdir /opt/splunk/etc/apps/TA_Snort3_json/local
sudo touch /opt/splunk/etc/apps/TA_Snort3_json/local/inputs.conf
sudo vi /opt/splunk/etc/apps/TA_Snort3_json/local/inputs.conf

```
**inputs.conf**  
```shell
[monitor:///var/log/snort/*alert_json.txt*]
sourcetype = snort3:alert:json

```

# 8. restart splunk

# 9. search via search and reporting
```shell
sourcetype="snort3:alert:json"

```
**To show the count of all events by message:**  
```shell
sourcetype="snort3:alert:json"
| stats count by msg

```
**To show all events sources on a map:**  
```shell
sourcetype="snort3:alert:json"
| iplocation src_addr
| stats count by Country
| geom geo_countries featureIdField="Country"

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
