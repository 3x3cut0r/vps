# n8n

**docker-compose.yml for n8n - a fair-code licensed workflow automation tool that combines AI capabilities with business process automation**

## Index

1. [deploy docker-compose.yml](#deploy)
2. [usage](#usage)  
   2.1 [browse](#browse)
3. [task runner](#taskrunner)

\# [Find Me](#findme)  
\# [License](#license)

# 1. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/n8n/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/n8n/docker-compose.yml)**

# 2. usage <a name="usage"></a>

### 2.1 browse <a name="browse"></a>

**Frontend**  
[https://n8n.3x3cut0r.de](https://n8n.3x3cut0r.de)

# 3. task runner <a name="taskrunner"></a>

The `n8n-task-runner` sidecar executes Code node JavaScript and Python in an isolated container (external mode).

- Documentation: https://docs.n8n.io/deploy/host-n8n/configure-n8n/set-up-task-runners
- The runner image tag must always match the n8n image tag exactly - update both together.
- Requires the `N8N_RUNNERS_AUTH_TOKEN` environment variable (shared secret between n8n and the runner).

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
