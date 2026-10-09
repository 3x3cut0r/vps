# firecrawl

**docker-compose.yml for firecrawl - a self-hosted web scraping API to crawl, scrape, map, search and parse websites**

## Index

1. [prerequisites](#prerequisites)
2. [configuration](#configuration)
3. [deploy docker-compose.yml](#deploy)
4. [usage](#usage)  
   4.1 [browse](#browse)  
   4.2 [api examples](#api)
5. [troubleshooting](#troubleshooting)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**System Requirements:**
- Docker and Docker Compose
- ~2 GB free RAM for small workloads (Playwright browser rendering is the main driver; upstream reference limits are 4 CPU/8 GB for the API and 2 CPU/4 GB for the Playwright service)

**Required:**
- environment variables `POSTGRES_PASSWORD` and `REDIS_PASSWORD` (see [configuration](#configuration))

# 2. configuration <a name="configuration"></a>

**Required environment variables** (set in the Portainer stack environment or in `docker/compose/firecrawl/.env`):

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_PASSWORD` | NuQ-Postgres password (queue backend, 32+ random chars) | `openssl rand -hex 32` |
| `REDIS_PASSWORD` | Redis password (queue + rate limit) | `openssl rand -hex 32` |

Example `.env`:

```env
POSTGRES_PASSWORD="<openssl rand -hex 32>"
REDIS_PASSWORD="<openssl rand -hex 32>"
```

**Static configuration** (set directly in `docker-compose.yml`):

| Variable | Description | Value |
|----------|-------------|-------|
| `POSTGRES_USER` | NuQ-Postgres user | `postgres` |
| `POSTGRES_DB` | NuQ-Postgres database (keep `postgres` - pg_cron is configured for it) | `postgres` |
| `USE_DB_AUTHENTICATION` | `false` = API runs without authentication (self-host default) | `false` |

**Optional environment variables** (add to the `firecrawl` service environment to tune, defaults in brackets):

| Variable | Description | Default |
|----------|-------------|---------|
| `NUM_WORKERS_PER_QUEUE` | Worker processes per queue | `8` |
| `CRAWL_CONCURRENT_REQUESTS` | Parallel requests per crawl | `10` |
| `MAX_CONCURRENT_JOBS` | Simultaneous crawl jobs | `5` |
| `BROWSER_POOL_SIZE` | Playwright browser pool size | `5` |
| `LOGGING_LEVEL` | Log verbosity | `info` |
| `OPENAI_API_KEY` | LLM features (extract, summary) | - |

**Required config files:**
- none (all configuration via environment variables)

**Security notes:**
- With `USE_DB_AUTHENTICATION=false` the API accepts requests without an API key and can fetch arbitrary URLs. Restrict port `3002` to trusted sources (reverse proxy, VPN) or front it with an authenticated reverse proxy. Note: Docker published ports bypass ufw INPUT rules - restrict access via the `DOCKER-USER` iptables chain (or a tool like `ufw-docker`), not via plain `ufw deny`.
- RabbitMQ (management UI), Postgres, Redis and the Playwright service are not published; they only listen on the internal `firecrawl` network.

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/firecrawl/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/firecrawl/docker-compose.yml)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**API**  
[https://firecrawl.3x3cut0r.de](https://firecrawl.3x3cut0r.de)

### 4.2 api examples <a name="api"></a>

**Health check**

```bash
curl https://firecrawl.3x3cut0r.de/v0/health/readiness
```

**Scrape a single page**

```bash
curl -X POST https://firecrawl.3x3cut0r.de/v2/scrape \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com"}'
```

**Crawl a site (async, returns a crawl id)**

```bash
curl -X POST https://firecrawl.3x3cut0r.de/v2/crawl \
  -H "Content-Type: application/json" \
  -d '{"url": "https://docs.firecrawl.dev", "limit": 10}'
```

# 5. troubleshooting <a name="troubleshooting"></a>

**`WORKER STALLED` / `Can't accept connection due to RAM/CPU load`**

Firecrawl's workers refuse new jobs when host memory or CPU load exceeds `MAX_RAM` / `MAX_CPU` (both default `0.8`). The values are read from the host (or LXC) via `/proc/meminfo`, not from the container.

- Check the actual memory usage on the VPS/LXC: `free -h`
- Reduce Firecrawl's own footprint by lowering the counts in the `firecrawl` service environment:
  - `NUM_WORKERS_PER_QUEUE` (default `8`)
  - `BROWSER_POOL_SIZE` (default `5`)
  - `CRAWL_CONCURRENT_REQUESTS` (default `10`)
- Only raise `MAX_RAM` / `MAX_CPU` if the host has real headroom - values close to `1.0` risk OOM kills.

**`[ioredis] ... ECONNREFUSED 127.0.0.1:6379`**

The rate limit and evict clients fall back to `127.0.0.1` when `REDIS_RATE_LIMIT_URL` is unset. It is set in `docker-compose.yml`; make sure `REDIS_PASSWORD` is provided (see [configuration](#configuration)).

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
