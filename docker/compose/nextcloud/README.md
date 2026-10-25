# nextcloud

**docker-compose.yml for nextcloud - nextcloud is a self-hosted file sync and share server (with postgresql, redis and onlyoffice)**

## Index

1. [deploy docker-compose.yml](#deploy)
2. [update nextcloud](#update)
3. [rollback](#rollback)

\# [Find Me](#findme)  
\# [License](#license)

# 1. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/nextcloud/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/nextcloud/docker-compose.yml)**

**post-installation steps are documented as comments inside the docker-compose.yml**

# 2. update nextcloud <a name="update"></a>

**patch updates (within the same major version) can be applied directly:**

```shell
docker compose pull nextcloud
docker compose up -d nextcloud
```

**major version upgrades must be done sequentially (N -> N+1). never skip a major version - the docker entrypoint aborts with an error if the image is more than one major ahead of the installed version (safe abort, no data loss, but downtime)**

**before every major upgrade:**

```shell
# database dump (on the nextcloud LXC)
docker exec nextcloud-postgres pg_dump -U nextcloud nextcloud > ~/nextcloud-$(date +%F).sql
# zfs snapshot (on the proxmox host)
zfs snapshot rpool/data/nextcloud-data@pre-nc-upgrade
```

**step 1 - update to the latest patch release of the current major version first (see [occ status](#verify))**

**step 2 - intermediate major upgrade via a temporary override file (example: 33 -> 34):**

```shell
cat > /tmp/nextcloud-34.yml <<EOF
services:
  nextcloud:
    image: nextcloud:34-apache
EOF
docker compose -f docker-compose.yml -f /tmp/nextcloud-34.yml pull nextcloud
docker compose -f docker-compose.yml -f /tmp/nextcloud-34.yml up -d nextcloud
docker logs -f nextcloud
```

**step 3 - let background migrations finish before the next major upgrade (run 2-3 times until no migration jobs are left):**

```shell
docker exec --user www-data nextcloud php cron.php
```

**step 4 - repeat steps 1-3 for every remaining major version, then deploy the target version from this repository (git pull on the LXC):**

```shell
docker compose pull nextcloud
docker compose up -d nextcloud
```

**step 5 - post-upgrade tasks:**

```shell
docker exec --user www-data nextcloud php occ db:add-missing-indices
# imagemagick extension is lost on every image update (see comment in docker-compose.yml)
docker exec nextcloud /bin/sh -c "apt update && apt install libmagickcore-6.q16-6-extra -y"
```

**verify the installed version <a name="verify"></a>**

```shell
docker exec --user www-data nextcloud php occ status
docker exec --user www-data nextcloud php occ setupchecks
```

# 3. rollback <a name="rollback"></a>

**downgrading nextcloud itself is not supported - restore the snapshot and the database dump taken before the upgrade:**

```shell
# zfs rollback (on the proxmox host)
zfs rollback rpool/data/nextcloud-data@pre-nc-upgrade
# restore database dump (on the nextcloud LXC)
docker exec -i nextcloud-postgres psql -U nextcloud nextcloud < ~/nextcloud-<date>.sql
```

**set the previous image tag in docker-compose.yml and redeploy**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
