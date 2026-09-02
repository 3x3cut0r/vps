# mattermost

Docker Compose stack for a self-hosted Mattermost Team Edition instance with PostgreSQL and Matterbridge.

## Services

- `mattermost` using `mattermost/mattermost-team-edition:11.7.10`
- `matterbridge` using `ghcr.io/matterbridge-org/matterbridge:latest`
- `mattermost-postgres` using `postgres:18-alpine`

## Files

- `docker-compose.yml`: stack definition
- `../../env-files/mattermost.env`: local Compose env template for `POSTGRES_PASSWORD`
- `matterbridge.toml.example`: Matterbridge configuration template for Telegram to Mattermost bridging

## Network

- Docker network `mattermost-app`: `10.24.48.0/26`
- Docker network `mattermost-db`: `10.24.48.64/26`
- Mattermost IPs: `10.24.48.2` on `mattermost-app`, `10.24.48.66` on `mattermost-db`
- PostgreSQL IP: `10.24.48.67` on `mattermost-db`
- Matterbridge IP: `10.24.48.4` on `mattermost-app`

## Ports

- Host port `8065` is published to container port `8065`
- Host port `8443` is published to container port `8443` for TCP and UDP
- Matterbridge does not publish host ports in this baseline setup

## Domain

- `MM_SERVICESETTINGS_SITEURL` is set to `https://mattermost.3x3cut0r.de`
- Matterbridge connects to Mattermost internally through `http://mattermost:8065`

## Volumes

- `mattermost-config` mounted to `/mattermost/config`
- `mattermost-data` mounted to `/mattermost/data`
- `mattermost-logs` mounted to `/mattermost/logs`
- `mattermost-plugins` mounted to `/mattermost/plugins`
- `mattermost-client-plugins` mounted to `/mattermost/client/plugins`
- `mattermost-bleve-indexes` mounted to `/mattermost/bleve-indexes`
- `mattermost-postgres-data` mounted to `/var/lib/postgresql`
- `/opt/docker/config-files/matterbridge/matterbridge.toml` mounted read-only to `/etc/matterbridge/matterbridge.toml`

## Matterbridge configuration

1. Copy the example file and keep the real configuration outside the repository:

```bash
mkdir -p /opt/docker/config-files/matterbridge
cp matterbridge.toml.example /opt/docker/config-files/matterbridge/matterbridge.toml
chmod 600 /opt/docker/config-files/matterbridge/matterbridge.toml
```

2. Edit `/opt/docker/config-files/matterbridge/matterbridge.toml` and replace all placeholder values:

- `Token`: Telegram bot token
- `Login` and `Password`: Mattermost bot or service account credentials
- `Team`: Mattermost team name
- `channel`: Telegram chat/channel and Mattermost channel names

3. The included template uses the internal Mattermost URL `http://mattermost:8065` so Matterbridge can stay inside the `mattermost-app` network without opening additional ports.

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
- Matterbridge is isolated from PostgreSQL by staying off the `mattermost-db` network
- Matterbridge uses the community-maintained fork `matterbridge-org/matterbridge`
- Matterbridge secrets live in `/opt/docker/config-files/matterbridge/matterbridge.toml` and should never be committed to Git
- Matterbridge will restart on invalid TOML or bad credentials, so check `docker compose logs matterbridge` first when the bridge does not come up
- No internal nginx, Redis, or Mattermost Calls service is included in this baseline stack
