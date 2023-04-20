# postgres

**docker-compose.yml for postgres**  

## Index

1. [deploy docker-compose.yml](#deploy)  
2. [reverse-proxy / nginx configuration](#reverse-proxy)  
3. [usage](#usage)  
  3.1 [browse](#browse)  
4. [update postgres](#update)    
5. [reset postgres password](#reset_password)    

\# [Find Me](#findme)  
\# [License](#license)  

# 1. deploy docker-compose.yml <a name="deploy"></a>  
**[see docker/docker-compose/postgres/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/postgres/docker-compose.yml)**  

# 2. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>  
**[see nginx/conf.d/pgadmin.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/pgadmin.conf)**  

# 4. usage <a name="usage"></a>  

### 4.1 browse <a name="browse"></a>  
**pgadmin**  
[https://pgadmin.3x3cut0r.de/admin](https://pgadmin.3x3cut0r.de/admin)  

# 5. update postgres <a name="update"></a>  
**1. stop all containers/stacks/services related to postgres with portainer (synapse, yacht, ...)**  
**2. make a backup/dump of all postgres databases on your docker host**  
```shell
# docker-compose exec {service_name} pg_dumpall -U {postgres_user} > dump.sql
docker container exec -it postgres pg_dumpall -U postgres > dump.sql

```
**3. delete postgres stack/service with portainer**  
**4. delete/move postgres-data volume and create new volume**  
```shell
mv /home/docker/volumes/postgres-data/ /home/docker/volumes/postgres-data-bak
docker volume rm postgres-data
docker volume rm pgadmin-data

```
**5. redeploy and start postgres stack/service with new version tag in docker-compose.yml**  
```shell
services:
  # https://hub.docker.com/_/postgres
    postgres:
        container_name: postgres
        image: postgres:14-alpine # before: postgres:13-alpine
...

```
**6. move dump.sql into the new postgres-data volume and change user rights**  
```shell
sudo mv /home/docker/dump.sql /home/docker/volumes/postgres-data/_data/
sudo ls -la /home/docker/volumes/postgres-data/_data/
# change user id
sudo chown 165xxx:165xxx /home/docker/volumes/postgres-data/_data/dump.sql

```

**7. connect into postgres container and restore dump.sql**  
```shell
docker container exec -it postgres /bin/bash
psql -U postgres -d postgres < /var/lib/postgresql/data/dump.sql

```

**8. if your import was successful without errors remove dump.sql**  
```shell
rm /var/lib/postgresql/data/dump.sql

```

**(9. reseting all passwords may necessary via pgadmin or console (see 6.))**  

# 6. reset postgres password <a name="reset_password"></a>  
```shell
docker container exec -it postgres /bin/bash
psql -U postgres
ALTER USER postgres WITH PASSWORD 'new_password';

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
