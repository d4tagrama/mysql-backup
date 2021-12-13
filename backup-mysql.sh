#!/bin/bash
CURRENT_DATE=$(/usr/bin/date "+%F-%H-%M-%S")
CMD_MYSQLDUMP=/usr/bin/mysqldump
CMD_MYSQL=/usr/bin/mysql

MYSQL_USER=<SET USERNAME>
MYSQL_PASSWORD=<SET PASSWORD>

LOG_FILE=/var/log/backup-cron.log

DST_BACKUP=/web/backup

for DB in $($CMD_MYSQL -u$MYSQL_USER -p$MYSQL_PASSWORD -e 'show databases' -s --skip-column-names);
do
    $CMD_MYSQLDUMP -u$MYSQL_USER -p$MYSQL_PASSWORD > $DST_BACKUP/$DB.sql >> $LOG_FILE
done
 
