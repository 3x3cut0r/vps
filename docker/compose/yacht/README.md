# yacht

**docker-compose.yml for yacht - a web interface for managing Docker containers with a dashboard and templates**

## Index

1. [prerequisites](#prerequisites)
2. [configuration](#configuration)
3. [deploy docker-compose.yml](#deploy)
4. [usage](#usage)  
   4.1 [browse](#browse)

\# [Find Me](#findme)  
\# [License](#license)

# 1. prerequisites <a name="prerequisites"></a>

**Create PostgreSQL user and database for Yacht:**

**User:**
```shell
General:
  Name: yacht

Definition:
  Password: <YACHT_POSTGRES_PASSWORD>
  Connection Limit: -1

Privileges:
  Can login?: Yes
```

**Database:**
```shell
General:
  Database: yacht
  Owner: yacht

Definition:
  Encoding: UTF8
  Template: postgres
  Tablespace: pg_default
  Collation: en_US.utf8
  Character type: en_US.utf8
  Connection Limit: -1
```

# 2. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `YACHT_POSTGRES_PASSWORD` | PostgreSQL password for yacht user | `your-yacht-db-password` |

# 3. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/yacht/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/yacht/docker-compose.yml)**

**First login:**
- Default password: `pass`
- Change the default password immediately after first login!

# 4. usage <a name="usage"></a>

### 4.1 browse <a name="browse"></a>

**Frontend**  
[https://yacht.3x3cut0r.de](https://yacht.3x3cut0r.de)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
