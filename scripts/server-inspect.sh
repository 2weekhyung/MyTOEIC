#!/usr/bin/env bash
# READ ONLY. Run on the Linux server; no passwords, inspect env, or container configs are printed.
set -euo pipefail
printf '%s\n' '== Available DB clients =='
command -v mysql >/dev/null && mysql --version || true
command -v mariadb >/dev/null && mariadb --version || true
command -v psql >/dev/null && psql --version || true
printf '%s\n' '== Containers: name/image/ports only =='
command -v docker >/dev/null && docker ps --format '{{.Names}} {{.Image}} {{.Ports}}' || true
printf '%s\n' 'Client version is NOT server version. In an authorized DB session run:'
printf '%s\n' 'MySQL/MariaDB: SELECT VERSION(), @@version_comment; SELECT DATABASE(); SHOW GRANTS;'
printf '%s\n' 'PostgreSQL: SELECT version(); SELECT current_database(), current_user;'
