#!/bin/bash
CMD_MYSQLDUMP="/usr/bin/mysqldump"
CMD_MYSQL="/usr/bin/mysql"

MYSQL_USER="<SET USERNAME>"
MYSQL_PASSWORD="<SET PASSWORD>"
MYSQL_HOST="127.0.0.1"

LOG_FILE="/var/log/backup-cron.log"
DST_BACKUP="/web/backup"

# Create log file if it doesn't exist
touch "$LOG_FILE"

# Check if destination backup directory exists, create if not
mkdir -p "$DST_BACKUP"

# Check if MySQL credentials are set
if [[ -z "$MYSQL_USER" || -z "$MYSQL_PASSWORD" ]]; then
    echo "MySQL username or password not set. Exiting."
    exit 1
fi

# Loop through databases and perform backup
for DB in $($CMD_MYSQL -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -e 'show databases' -s --skip-column-names); do
    CURRENT_DATE=$(date "+%F-%H:%M:%S")
    echo "$CURRENT_DATE START BACKUP DB: $DB" | tee -a "$LOG_FILE"
    if $CMD_MYSQLDUMP -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" "$DB" > "$DST_BACKUP/$DB.$CURRENT_DATE.sql"; then
        echo "$CURRENT_DATE END   BACKUP DB: $DB" | tee -a "$LOG_FILE"
    else
        echo "Failed to backup $DB database." | tee -a "$LOG_FILE"
    fi
done

# Logging to syslog
logger -p user.info "MySQL database backup completed."
