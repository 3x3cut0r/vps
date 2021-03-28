# Synapse / Matrix

# 1. Initialise

## 1.1 initialise Synapse
```shell
docker network create \
    --driver=bridge \
    --subnet=10.20.144.0/20 \
    --gateway=10.20.144.2 \
    synapse

docker run -it --rm \
    --name=synapse \
    --network=synapse \
    -e SYNAPSE_SERVER_NAME='matrix.3x3cut0r.de' \
    -e SYNAPSE_REPORT_STATS='yes' \
    -e TZ='Europe/Berlin' \
    -e UID=991 \
    -e GID=991 \
    -v synapse-data:/data \
    matrixdotorg/synapse:latest generate

docker network rm synapse

```

## 1.2 create postgres user and database
**1. connect to your postgres database with pgadmin**  
**2. make sure on Preferences/Browser/Display:"Show system objects? = true"**  
**3. create a login/user for your synapse database like this:**  
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
**4. create a databese for synapse like this:**  
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
**NOTE: if template0 is not shown, see 2. !**  
**NOTE: Collation and Character type has to be "C". otherwise synapse won't start !!!**

## 1.3 prepare your homeserver.yaml
**/home/docker/.local/share/docker/volumes/synapse-data/_data/homeserver.yaml**  
**use the [homeserver.yaml](https://github.com/3x3cut0r/vps/blob/main/docker/docker-compose/synapse/homeserver.yaml) on my repo as template

# 2. deploy docker-compose.yml

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
