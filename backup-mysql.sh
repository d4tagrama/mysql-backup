#!/bin/bash
CMD_MYSQLDUMP=/usr/bin/mysqldump
CMD_MYSQL=/usr/bin/mysql

MYSQL_USER=<SET USERNAME>
MYSQL_PASSWORD=<SET PASSWORD>
MYSQL_HOST=127.0.0.1


LOG_FILE=/var/log/backup-cron.log

DST_BACKUP=/web/backup

for DB in $($CMD_MYSQL -u$MYSQL_USER -p$MYSQL_PASSWORD -e 'show databases' -s --skip-column-names);
do
    CURRENT_DATE=$(/usr/bin/date "+%F-%H:%M:%S")
    echo "$CURRENT_DATE START BACKUP DB: $DB" >> $LOG_FILE
    $CMD_MYSQLDUMP -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $DB> $DST_BACKUP/$DB.$CURRENT_DATE.sql
    CURRENT_DATE=$(/usr/bin/date "+%F-%H-%M-%S")
    echo "$CURRENT_DATE END   BACKUP DB: $DB" >> $LOG_FILE
done
 
