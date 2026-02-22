# anythingllm

**docker-compose.yml for anythingllm - a self-hosted AI knowledge management and chat application with support for multiple LLM providers**

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
- OpenAI API Key from https://platform.openai.com/api-keys
- PostgreSQL database (for persistent storage)
- Qdrant vector database (included in docker-compose)

# 2. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `AUTH_TOKEN` | Authentication token for AnythingLLM | `your-auth-token` |
| `JWT_SECRET` | JWT secret for session management | `your-jwt-secret` |
| `OPEN_AI_KEY` | OpenAI API key | `sk-...` |

**Optional environment variables:**
- `LLM_PROVIDER` - LLM provider (default: `openai`)
- `OPEN_MODEL_PREF` - OpenAI model preference (default: `gpt-4`)
- `EMBEDDING_ENGINE` - Embedding engine (default: `openai`)
- `EMBEDDING_MODEL_PREF` - Embedding model (default: `text-embedding-3-small`)
- `VECTOR_DB` - Vector database (default: `qdrant`)

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/anythingllm/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/anythingllm/docker-compose.yml)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://anythingllm.3x3cut0r.de](https://anythingllm.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
