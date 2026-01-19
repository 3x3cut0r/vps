
# backup postgres globals
docker exec -i postgres pg_dumpall --globals-only -U postgres > globals.sql

# list postgres databases
docker exec -it postgres psql -U postgres -Atc '\l'

# backup postgres databases
for db in synapse maubot mautrix-telegram mautrix-whatsapp mautrix-signal mx-puppet-discord; do
  echo "Dumping $db ..."
  docker exec -i postgres pg_dump -U postgres -Fc -Z 9 "$db" > "${db}.dump"
done

# copy dumps into container
docker cp globals.sql synapse-postgres:/globals.sql
for db in synapse maubot mautrix-telegram mautrix-whatsapp mautrix-signal mx-puppet-discord; do
  docker cp "$db.dump" synapse-postgres:/
done

# restore postgres globals
docker exec -i synapse-postgres psql -U synapse -d postgres < globals.sql || true

# restore postgres databases (repeat for all databases)
DBS=(synapse maubot "mautrix-signal" "mautrix-telegram" "mautrix-whatsapp" "mx-puppet-discord")

for db in "${DBS[@]}"; do
  docker exec -i synapse-postgres psql -U postgres -d postgres -v ON_ERROR_STOP=1 <<SQL
DO \$\$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='${db}') THEN
    CREATE ROLE "${db}" LOGIN;
  END IF;
END
\$\$;
SQL
done

for db in "${DBS[@]}"; do
  docker exec -i synapse-postgres psql -U postgres -d postgres -v ON_ERROR_STOP=1 <<SQL
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname='${db}' AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS "${db}";
CREATE DATABASE "${db}" OWNER "${db}" TEMPLATE template0;
SQL
done

for db in "${DBS[@]}"; do
  docker exec -i synapse-postgres pg_restore \
    -U postgres \
    -d "${db}" \
    --clean \
    --if-exists \
    --no-owner \
    "/${db}.dump"
done

# check after
docker exec -i synapse-postgres psql -U postgres -d postgres -c "SELECT datname, datcollate, datctype FROM pg_database ORDER BY 1;"


