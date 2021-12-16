# Rocket.Chat

howto deploy rocket.chat

## Index

1. [download mongod.conf](#mongod.conf)   
2. [docker-compose](#docker-compose)  
3. [known errors](#known_errors)  
4. [dark mode](#dark-mode)  

\# [Find Me](#findme)  
\# [License](#license)  

# 1. download mongod.conf <a name="mongod.conf"></a>
**Path:**
```shell
/home/docker/config-files/mongodb/mongod.conf

```

# 2. docker-compose <a name="docker-compose"></a>
**OR deploy with portainer (recommended)**
```shell
docker-compose up -d

```

# 3. known errors <a name="known_errors"></a>
on the first deploy you will get some errors in mongo and rocketchat log ...  
give mongo some time for the replSet to be up ...  
restart mongo ... wait until mongo is up  
restart rocketchat  

**if rocketchat couldn't start because of error: not master and slaveOk=false**  
```shell
docker container exec -it mongo /bin/#!/usr/bin/env bash
mongo
rs.reconfig({ "_id" : "rs0", "version" : 1, "members" : [{ "_id" : 0, "host" : "mongo:27017", "arbiterOnly" : false, "buildIndexes" : true, "hidden" : false, "priority" : 1, "slaveDelay" : NumberLong(0), "votes" : 1 }] }, {force : true})
exit
exit

```

# 4. dark mode <a name="dark-mode"></a>
**for dark mode visit [github.com/pbaity/rocketchat-dark-mode](https://github.com/pbaity/rocketchat-dark-mode)**

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
