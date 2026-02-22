# Rocket.Chat

**docker-compose.yml for Rocket.Chat - an open-source team chat platform similar to Slack**

## Index

1. [download mongod.conf](#mongod.conf)
2. [deploy docker-compose.yml](#deploy)
3. [Initialise ReplSet rs0](#replset)
4. [usage](#usage)  
   4.1 [browse](#browse)
5. [known errors](#known_errors)
6. [dark mode](#dark-mode)
7. [downgrade](#downgrade)

\# [Find Me](#findme)  
\# [License](#license)

# 1. download mongod.conf <a name="mongod.conf"></a>

**[see docker/compose/rocketchat/mongodb/mongod.conf](https://github.com/3x3cut0r/vps/blob/main/docker/compose/rocketchat/mongodb/mongod.conf)**

**Path:**
```shell
/home/docker/config-files/mongodb/mongod.conf
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/rocketchat/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/rocketchat/docker-compose.yml)**

# 3. Initialise ReplSet rs0 <a name="replset"></a>

**Run after first deployment:**
```shell
docker container exec -it mongo mongo --eval "printjson(rs.initiate())"
```

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://chat.3x3cut0r.de](https://chat.3x3cut0r.de)

# 5. known errors <a name="known_errors"></a>

On the first deploy you will get some errors in mongo and rocketchat log...  
Give mongo some time for the replSet to be up...  
Restart mongo ... wait until mongo is up  
Restart rocketchat

**If rocketchat couldn't start because of error: not master and slaveOk=false:**
```shell
docker container exec -it mongo /bin/bash
mongo
rs.reconfig({ "_id" : "rs0", "version" : 1, "members" : [{ "_id" : 0, "host" : "mongo:27017", "arbiterOnly" : false, "buildIndexes" : true, "hidden" : false, "priority" : 1, "slaveDelay" : NumberLong(0), "votes" : 1 }] }, {force : true})

# For error code 103: Incompatible delay field name, use:
rs.reconfig({ "_id" : "rs0", "version" : 1, "members" : [{ "_id" : 0, "host" : "mongo:27017", "arbiterOnly" : false, "buildIndexes" : true, "hidden" : false, "priority" : 1, "secondaryDelaySecs" : NumberLong(0), "votes" : 1 }] }, {force : true})

exit
exit
```

# 6. dark mode <a name="dark-mode"></a>

**For dark mode visit [github.com/pbaity/rocketchat-dark-mode](https://github.com/pbaity/rocketchat-dark-mode)**

# 7. downgrade to previous version <a name="downgrade"></a>

**It is highly not recommended to do this!**

**1. Downgrade version by adding previous version as docker image tag in docker-compose.yml**

**2. Connect to mongo and migrate from current to a previous mongo database version number (e.g. 253->252):**
```shell
docker container exec -it mongo /bin/bash
mongo
use rocketchat
db.migrations.update({"version":253},{"version":252})
exit
exit
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
