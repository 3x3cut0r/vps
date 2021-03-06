# Nextcloud

# 1. download php-filesize.ini (and prepare if you want)
**copy and replace from repo**  
```shell
mkdir -p /home/docker/config-files/nextcloud
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/docker-compose/nextcloud/php-filesize.ini -O /home/docker/config-files/nextcloud/php-filesize.ini

```

# 2. deploy docker-compose.yml

# 3. configure your nginx reverse proxy
**see: [nextcloud.conf](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/nginx/conf.d/nextcloud.conf)**

# 4. disable app richdocumentscode (makes nextcloud fast again)
```shell
docker exec -u www-data nextcloud php occ app:disable richdocumentscode

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
