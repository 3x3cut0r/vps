# snort3

**delete snort3 logs except last 7 days**  
```shell
sudo find /var/log/snort/ -type f -mtime +6 | grep -v snort.pid | xargs rm

```

**fix: FATAL: snort3 ips.rules:3 undefined variable name: RULE_PATH**
```shell
vi /usr/local/etc/snort/snort.lua

ips =
{
    -- use this to enable decoder and inspector alerts
    enable_builtin_rules = true,

    -- use include for rules files; be sure to set your path
    -- note that rules files can include other rules files
    --include = 'snort3-community.rules',

    -- RULE_PATH is typically set in snort_defaults.lua
    rules = [[

        ...

    ]]

    variables = default_variables
    --variables = default_variables_singletable

```

### Find Me <a name="findme"></a>

![E-Mail](https://img.shields.io/badge/E--Mail-executor55%40gmx.de-red)
* [GitHub](https://github.com/3x3cut0r)
* [DockerHub](https://hub.docker.com/u/3x3cut0r)

### License <a name="license"></a>

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) - This project is licensed under the GNU General Public License - see the [gpl-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) for details.
