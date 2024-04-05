# skel

**docker-compose.yml for skel - skel is a ...**

## Index

1. [prerequisites](#prerequisites)
2. [deploy docker-compose.yml](#deploy)
3. [reverse-proxy / nginx configuration](#reverse-proxy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**get you OpenAI API Key from https://platform.openai.com/api-keys**  
**change OPEN_AI_KEY and JWT_SECRET in docker-compose.yml**

```shell
services:
  anythingllm:
    environment:
      OPEN_AI_KEY: '<sk-1234>'
      JWT_SECRET: '<my-random-string-for-seeding>'
```

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/skel/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/skel/docker-compose.yml)**

# 3. reverse-proxy / nginx configuration <a name="reverse-proxy"></a>

**add new proxy host to your nginx or nginx-proxy-manager**
**[see nginx/conf.d/skel.conf](https://github.com/3x3cut0r/vps/blob/main/nginx/conf.d/skel.conf)**

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://skel.3x3cut0r.de](https://skel.3x3cut0r.de)

**Backend**  
[https://skel.3x3cut0r.de/admin](https://skel.3x3cut0r.de/admin)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
