# mattermost

Docker Compose stack for a self-hosted Mattermost Team Edition instance with PostgreSQL.

## Services

- `mattermost` using `mattermost/mattermost-team-edition:11.7.0`
- `mattermost-postgres` using `postgres:18-alpine`

## Files

- `docker-compose.yml`: stack definition
- `../../env-files/mattermost.env`: local Compose env template for `POSTGRES_PASSWORD`

## Network

- Docker network: `mattermost`
- Subnet: `10.24.49.0/24`
- Mattermost IP: `10.24.49.2`
- PostgreSQL IP: `10.24.49.3`

## Ports

- Host loopback `127.0.0.1:2149` is published to container port `8065`

## Domain

- `MM_SERVICESETTINGS_SITEURL` is set to `https://mattermost.3x3cut0r.de`
- A reverse proxy on the same host can forward traffic to `http://127.0.0.1:2149`

## Volumes

- `mattermost-config` mounted to `/mattermost/config`
- `mattermost-data` mounted to `/mattermost/data`
- `mattermost-logs` mounted to `/mattermost/logs`
- `mattermost-plugins` mounted to `/mattermost/plugins`
- `mattermost-client-plugins` mounted to `/mattermost/client/plugins`
- `mattermost-bleve-indexes` mounted to `/mattermost/bleve-indexes`
- `mattermost-postgres-data` mounted to `/var/lib/postgresql`

## Run

```bash
docker compose --env-file ../../env-files/mattermost.env up -d
```

```bash
docker compose down
```

## Notes

- DNS inside the containers is set to `192.168.40.253`
- The stack includes WUD labels for image monitoring
- `POSTGRES_PASSWORD` is intentionally left empty in the tracked env template and must be provided before deployment
- In Portainer, set `POSTGRES_PASSWORD` as a stack environment variable before deployment
- If the password contains reserved URL characters such as `@`, `:`, `/`, `?`, `#`, or `%`, store it URL-encoded because it is embedded in the Mattermost PostgreSQL DSN
- No internal nginx, Redis, or Mattermost Calls service is included in this baseline stack
