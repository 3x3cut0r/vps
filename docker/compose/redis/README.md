# redis

**docker-compose.yml for redis - an in-memory data structure store used as database, cache, message broker, and streaming engine**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `REDIS_PASSWORD` | Password for Redis authentication | `your-redis-password` |

**Two Redis instances:**
- `redis` - Password protected (network: 10.20.96.0/20)
- `redis-nopw` - No password (network: 10.20.112.0/20)

**Connect other containers to Redis network:**
```yaml
networks:
  redis:
    external:
      name: redis
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/redis/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/redis/docker-compose.yml)**

# 3. usage <a name="usage"></a>

**Connect to Redis:**
```shell
docker container exec -it redis redis-cli -a ${REDIS_PASSWORD}
```

**Connect from another container:**
```shell
redis-cli -h redis -a ${REDIS_PASSWORD}
```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
