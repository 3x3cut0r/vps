# Nextcloud

# 1. download php-filesize.ini (and prepare if you want)
**copy and replace from repo**  
```shell
mkdir -p /home/docker/config-files/nextcloud
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/nextcloud/php-filesize.ini -O /home/docker/config-files/nextcloud/php-filesize.ini

```

# 2. deploy docker-compose.yml

# 3. configure your nginx reverse proxy
**see: [nextcloud.conf](https://github.com/3x3cut0r/vps/blob/main/docker/compose/nginx/conf.d/nextcloud.conf)**

# 4. configure config/config.php
**make sure these settings are set in your config/config.php**  
**you need to do this as root**  
```shell
<?php
$CONFIG = array (
  ...
  'filelocking.enabled\' => 'true',
  'onlyoffice' =>
  array (
    'verify_peer_off' => true,
  ),
  'loglevel' => 2,
  'logdateformat' => 'Y-m-d:H:m:s',
  'default_locale' => 'de_DE',
  'default_phone_region' => 'DE',
  'maintenance' => false,
);

```

# 5. disable app richdocumentscode (makes nextcloud fast again)
```shell
docker exec -u www-data nextcloud php occ app:disable richdocumentscode

```

# 6. install image-magick
```shell
docker container exec -it nextcloud /bin/bash
apt update
apt install libmagickcore-6.q16-6-extra

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
