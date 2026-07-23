# affine

**docker-compose.yml for AFFiNE - self-hosted knowledge base, docs, and collaboration platform**

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
- Docker and Docker Compose
- Reverse proxy with WebSocket support

**Required:**
- A public DNS record for `affine.3x3cut0r.de`
- Environment variables for Postgres credentials

# 2. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `AFFINE_REVISION` | AFFiNE image tag channel | `stable` |
| `AFFINE_POSTGRES_DATABASE` | PostgreSQL database name | `affine` |
| `AFFINE_POSTGRES_USERNAME` | PostgreSQL username | `affine` |
| `AFFINE_POSTGRES_PASSWORD` | PostgreSQL password | `change-me` |

**Notes:**
- Internal container port is `3010`, exposed on host port `2148`
- First admin user is created via `https://affine.3x3cut0r.de/admin`
- Advanced server settings may move into `config.json` in newer AFFiNE releases

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/affine/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/affine/docker-compose.yml)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://affine.3x3cut0r.de](https://affine.3x3cut0r.de)

**Backend**  
[https://affine.3x3cut0r.de/admin](https://affine.3x3cut0r.de/admin)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
