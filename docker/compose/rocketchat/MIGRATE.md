# do a snapshot of the lxc container first !
pct snapshot 192 pre-rc-migrate
pct snapshot 200 pre-rc-migrate

# control mongodb version compatibility
curl -fsSL https://releases.rocket.chat/7.13.3/info | jq

# stop container (except mongo)
docker container stop rocketchat hubot

# export root password temporarly
export MONGO_ROOT_PASSWORD='YOUR_MONGO_ROOT_PASSWORD'
export MONGO_PASSWORD='YOUR_MONGO_PASSWORD'

# list available databases
docker exec -it mongo mongosh --quiet --eval 'db.adminCommand({listDatabases: 1}).databases.map(d => `${d.name}\t${d.sizeOnDisk}` ).join("\n")'

# create a full database dump out of the mongo container
mkdir -p /opt/backup/docker/volumes/mongo-dump &&
docker exec -t mongo bash -lc '
mkdir -p /bitnami/mongodb/dump &&
/opt/bitnami/mongodb/bin/mongodump --host 127.0.0.1 --port 27017 --archive=/bitnami/mongodb/dump/mongo.archive.gz --gzip
' && docker cp mongo:/bitnami/mongodb/dump/mongo.archive.gz /opt/backup/docker/volumes/mongo-dump/mongo.archive.gz

# create a mongo-keyfile (999 = mongo user)
mkdir -p /opt/docker/config-files/mongo
openssl rand -base64 756 > /opt/docker/config-files/mongo/mongo-keyfile
chmod 600 /opt/docker/config-files/mongo/mongo-keyfile
chown 999:999 /opt/docker/config-files/mongo/mongo-keyfile

# deploy rocketchat stack and immediately stop rocketchat

# mongo init replicaset
docker exec -it mongo mongosh -u root -p "$MONGO_ROOT_PASSWORD" --authenticationDatabase admin --quiet --eval '
try { if (rs.status().ok === 1) { print("already initialized"); quit(0); } } catch (e) {}
rs.initiate({_id:"rs0", members:[{_id:0, host:"mongo:27017"}]});
print("replicaset initiated");
'

# mongo restore
docker cp /opt/backup/docker/volumes/mongo-dump/mongo.archive.gz mongo:/tmp/mongo.archive.gz
docker exec -it mongo bash -lc '
  mongorestore \
    --host 127.0.0.1 --port 27017 \
    -u root -p "$MONGO_ROOT_PASSWORD" --authenticationDatabase admin \
    --archive=/tmp/mongo.archive.gz --gzip \
    --drop
'

# create mongo user rocketchat (but change PASSWORD)
docker exec -it mongo mongosh -u root -p "$MONGO_ROOT_PASSWORD" --authenticationDatabase admin --quiet --eval '
db.getSiblingDB("admin").createUser({
  user: "rocketchat",
  pwd: "YOUR__MONGO_PASSWORD__IN_PLAIN_TEXT_AND_NOT_AS_ENV_VARIABLE",
  roles: [
    { role: "readWrite", db: "rocketchat" },
    { role: "read", db: "local" }
  ],
  mechanisms: ["SCRAM-SHA-256","SCRAM-SHA-1"]
});
print("created user rocketchat in admin");
'

# start container again
docker container start rocketchat hubot

# clear history
history -c

