# open-webui

**docker-compose.yml for open-webui - a self-hosted WebUI for AI interactions with LiteLLM integration**

## Index

1. [prerequisites](#prerequisites)
2. [configuration](#configuration)
3. [deploy docker-compose.yml](#deploy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**Required:**
- PostgreSQL database (for persistent storage)
- External networks: `ai-hub-postgres`, `mcp-gateways`, `llama-cpp`

# 2. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `WEBUI_SECRET_KEY` | Secret key for session management | `your-webui-secret` |
| `LITELLM_MASTER_KEY` | LiteLLM master API key | `your-litellm-key` |
| `LITELLM_SALT_KEY` | LiteLLM salt key | `your-litellm-salt` |
| `UI_PASSWORD` | LiteLLM UI password | `your-ui-password` |
| `OPENWEBUI_POSTGRES_PASSWORD` | PostgreSQL password for OpenWebUI | `your-pg-password` |
| `LITELLM_POSTGRES_PASSWORD` | PostgreSQL password for LiteLLM | `your-pg-password` |

**Included services:**
- `open-webui` - Main WebUI (port 2139)
- `litellm` - LLM proxy (port 2439)
- `mcpo` - MCP server

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/open-webui/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/open-webui/docker-compose.yml)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://open-webui.3x3cut0r.de](https://open-webui.3x3cut0r.de)

**LiteLLM UI**  
[https://litellm.3x3cut0r.de](https://litellm.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
