# Synapse / Matrix

**docker-compose.yml for Synapse - a Matrix homeserver for decentralized, secure communication**

## Index

1. [initialise Synapse](#initialise)
2. [create postgres user and database](#postgres)
3. [prepare homeserver.yaml](#homeserver)
4. [deploy docker-compose.yml](#deploy)
5. [usage](#usage)  
   5.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. initialise Synapse <a name="initialise"></a>

```shell
docker network create \
    --driver=bridge \
    --subnet=10.20.144.0/20 \
    --gateway=10.20.144.2 \
    synapse

docker run -it --rm \
    --name=synapse \
    --network=synapse \
    -e SYNAPSE_SERVER_NAME='3x3cut0r.de' \
    -e SYNAPSE_REPORT_STATS='yes' \
    -e TZ='Europe/Berlin' \
    -e UID=991 \
    -e GID=991 \
    -v synapse-data:/data \
    matrixdotorg/synapse:latest generate

docker network rm synapse
```

# 2. create postgres user and database <a name="postgres"></a>

**1. Connect to your postgres database with pgAdmin**

**2. Make sure Preferences/Browser/Display: "Show system objects? = true"**

**3. Create a login/user for Synapse:**
```shell
right-click on Login/Group Roles / Create / Login/Group Role...

General:
    Name: synapse

Definition:
    Password: <STRONG_SYNAPSE_POSTGRES_PASSWORD>

Privileges:
    Can login? Yes

SAVE
```

**4. Create a database for Synapse:**
```shell
right-click on Databases / Create / Database...

Database: synapse
Owner: synapse

Definition:
Encoding: UTF8
Template: template0
Tablespace: pg_default
Collation: C
Character type: C
Connection limit: -1

SAVE
```

**NOTE: Collation and Character type has to be "C". otherwise synapse won't start!**

# 3. prepare homeserver.yaml <a name="homeserver"></a>

**Path: `/home/docker/.local/share/docker/volumes/synapse-data/_data/homeserver.yaml`**

Use the [homeserver.yaml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/synapse/homeserver.yaml) as template.

# 4. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/synapse/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/synapse/docker-compose.yml)**

# 5. usage <a name="usage"></a>

### 5.1 browse <a name="browse"></a>

**Frontend**  
[https://matrix.3x3cut0r.de](https://matrix.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
