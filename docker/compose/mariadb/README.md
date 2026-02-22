# mariadb

**docker-compose.yml for mariadb - a community-developed fork of MySQL, one of the most popular open source relational databases**

## Index

1. [configuration](#configuration)
2. [deploy docker-compose.yml](#deploy)
3. [usage](#usage)  
   3.1 [browse](#browse)
4. [fine-tune configuration](#finetune)

\# [Find Me](#findme)  
\# [License](#license)

# 1. configuration <a name="configuration"></a>

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `MYSQL_ROOT_PASSWORD` | Root user password | `your-mysql-root-password` |

**Included services:**
- `mariadb` - MariaDB 10 database (port 3306, internal only)
- `phpmyadmin` - phpMyAdmin web interface (port 2200)

**Connect other containers to mariadb network:**
```yaml
networks:
  mariadb:
    external:
      name: mariadb
```

**Required config files:**
- `/opt/docker/config-files/phpmyadmin/config.user.inc.php`
- `/opt/docker/config-files/phpmyadmin/php.ini`

# 2. deploy docker-compose.yml <a name="deploy"></a>

**[see docker/compose/mariadb/docker-compose.yml](https://github.com/3x3cut0r/vps/blob/main/docker/compose/mariadb/docker-compose.yml)**

# 3. usage <a name="usage"></a>

### 3.1 browse <a name="browse"></a>

**phpMyAdmin**  
[https://phpmyadmin.3x3cut0r.de](https://phpmyadmin.3x3cut0r.de)

# 4. fine-tune configuration <a name="finetune"></a>

**Copy and replace from repo:**
```shell
wget -q https://raw.githubusercontent.com/3x3cut0r/vps/main/docker/compose/mariadb/50-server.cnf -O /home/docker/.local/share/docker/volumes/mariadb-conf/_data/50-server.cnf
```

**Or modify mariadb-conf/_data/50-server.cnf:**
```shell
skip-name-resolve

key_buffer_size        = 1G
max_allowed_packet     = 1G
thread_stack           = 192K
thread_cache_size      = 128
max_connections        = 100
table_cache            = 128
tmp_table_size         = 1G
max_heap_table_size    = 1G

expire_logs_days        = 10
max_binlog_size         = 100M

character-set-server  = utf8mb4
collation-server      = utf8mb4_general_ci

innodb_buffer_pool_size = 8G
```

**Restart MariaDB:**
```shell
docker container restart mariadb
```

**Check database security:**
Download and exec mysqltuner.pl: [mysqltuner.pl on GitHub](https://github.com/major/MySQLTuner-perl)

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)

- [GitHub](https://github.com/3x3cut0r)
- [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
