#!/usr/bin/env bash
# Requires a local chmod-600 MySQL option file; never pass a password as a command argument.
# Usage: bash scripts/backup.sh /private/backup.cnf /private/backups
set -euo pipefail
umask 077
config=${1:?Path to private MySQL option file required}
backup_dir=${2:?Backup directory required}
[[ -f "$config" ]] || { echo 'Option file not found' >&2; exit 1; }
mkdir -p "$backup_dir"
stamp=$(date -u +%Y%m%dT%H%M%SZ)
target="$backup_dir/mytoeic-$stamp.sql.gz"
partial="$target.partial"
trap 'rm -f -- "$partial"' EXIT
# This dumps ONLY mytoeic. No --all-databases or --databases; restore target is explicit.
mysqldump --defaults-extra-file="$config" --single-transaction --quick --no-tablespaces --skip-add-locks \
  --set-gtid-purged=OFF --column-statistics=0 --skip-add-drop-table mytoeic | gzip > "$partial"
gzip -t "$partial"
mv -- "$partial" "$target"
sha256sum "$target" > "$target.sha256"
printf 'Backup created: %s\n' "$target"
