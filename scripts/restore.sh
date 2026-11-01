#!/usr/bin/env bash
# Refuses live mytoeic. Restore to a NEW, EMPTY mytoeic_restore_* database first.
# Usage: bash scripts/restore.sh /private/restore.cnf backup.sql.gz mytoeic_restore_20261030
set -euo pipefail
config=${1:?Private MySQL option file required}
archive=${2:?Backup archive required}
target_db=${3:?New restore database required}
[[ "$target_db" =~ ^mytoeic_restore_[a-zA-Z0-9_]+$ ]] || { echo 'Use a NEW mytoeic_restore_* database' >&2; exit 1; }
[[ -f "$archive.sha256" ]] || { echo 'Checksum file required' >&2; exit 1; }
sha256sum --check "$archive.sha256"
gzip -t "$archive"
exists=$(mysql --defaults-extra-file="$config" --batch --skip-column-names -e "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name='$target_db'")
[[ "$exists" == 0 ]] || { echo 'Refusing an existing target database' >&2; exit 1; }
# An operator must approve this before running. No DROP/overwrite or production cutover.
mysql --defaults-extra-file="$config" -e "CREATE DATABASE \`$target_db\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
gzip -dc "$archive" | mysql --defaults-extra-file="$config" "$target_db"
printf 'Restored to %s. Verify counts and Flyway history before any cutover.\n' "$target_db"
