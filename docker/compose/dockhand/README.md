# Dockhand

**docker-compose.yml for Dockhand - Dockhand is a Docker management interface.**

## Index

1. [prerequisites](#prerequisites)
2. [configuration](#configuration)
3. [deploy docker-compose.yml](#deploy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**System Requirements:**
- Docker is installed.
- Docker Compose is installed.

**Required:**
- Access to `/var/run/docker.sock` for Docker management.
- Host port `2147` is available.

# 2. configuration <a name="configuration"></a>

**Required environment variables:**

No required environment variables are configured.

**Required volumes:**
- `/var/run/docker.sock:/var/run/docker.sock`
- `dockhand-data:/app/data`

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/dockhand/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/dockhand/docker-compose.yml)**

```bash
docker compose up -d
```

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[http://localhost:2147](http://localhost:2147)

### Security note

Dockhand mounts `/var/run/docker.sock` into the container. This gives the container broad control over the Docker host. Only run this stack with a trusted image and restrict network exposure where possible.

The web interface is published on host port `2147`. For internet-facing deployments, place Dockhand behind TLS, authentication, and optional IP restrictions. If Dockhand supports it in the future, prefer a restricted Docker socket proxy over direct Docker socket access.

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
