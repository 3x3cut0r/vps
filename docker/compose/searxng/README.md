# searxng

Docker Compose stack for a self-hosted SearXNG instance with Valkey.

## Services

- `searxng` using `docker.io/searxng/searxng:latest`
- `valkey` using `docker.io/valkey/valkey:9-alpine`

## Files

- `docker-compose.yml`: stack definition

## Network

- Docker network: `searxng`
- Subnet: `10.24.46.0/24`
- SearXNG IP: `10.24.46.2`
- Valkey IP: `10.24.46.3`

## Ports

- Host port `2146` is published to container port `8080`

## Domain

- `SEARXNG_BASE_URL` is set to `https://searxng.3x3cut0r.de/`
- A reverse proxy can forward traffic to `http://<docker-host>:2146`

## Volumes

- `searxng-config` mounted to `/etc/searxng/`
- `searxng-data` mounted to `/var/cache/searxng/`
- `searxng-valkey-data` mounted to `/data/`

## Run

```bash
docker compose up -d
```

```bash
docker compose down
```

## Notes

- DNS inside the containers is set to `192.168.40.253`
- The stack includes WUD labels for image monitoring
- `SEARXNG_VALKEY_URL` points to `valkey://valkey:6379/0`
