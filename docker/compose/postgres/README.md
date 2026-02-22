# postgres

**docker-compose.yml for postgres - a powerful, open source object-relational database system with pgAdmin and Adminer**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)  
   3.1 [browse](#browse)
4. [update postgres](#update)
5. [reset postgres password](#reset_password)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_DB` | Default database name | `postgres` |
| `POSTGRES_USER` | Superuser username | `postgres` |
| `POSTGRES_PASSWORD` | Superuser password | `your-postgres-password` |
| `PGADMIN_DEFAULT_PASSWORD` | pgAdmin login password | `your-pgadmin-password` |

**Included services:**
- `postgres` - PostgreSQL 15 database (port 5432, internal only)
- `pgadmin` - pgAdmin4 web interface (port 5050)
- `adminer` - Adminer web interface (port 2201)

**Connect other containers to postgres network:**
```yaml
networks:
  postgres:
    external:
      name: postgres
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/postgres/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/postgres/docker-compose.yml)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**pgAdmin**  
[https://pgadmin.3x3cut0r.de](https://pgadmin.3x3cut0r.de)

**Adminer**  
[https://adminer.3x3cut0r.de](https://adminer.3x3cut0r.de)

# 4. update postgres <a name="update"></a>

**1. stop all containers/stacks/services related to postgres with portainer (synapse, yacht, ...)**  
**2. make a backup/dump of all postgres databases on your docker host**
```shell
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
```yaml
services:
  postgres:
    image: postgres:16-alpine # before: postgres:15-alpine
```

**6. move dump.sql into the new postgres-data volume and change user rights**
```shell
sudo mv /home/docker/dump.sql /home/docker/volumes/postgres-data/_data/
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

# 5. reset postgres password <a name="reset_password"></a>

```shell
docker container exec -it postgres /bin/bash
psql -U postgres
ALTER USER postgres WITH PASSWORD 'new_password';
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
