# mysql-backup

This tool is a basic script that allow DBA generate a automatic backup using `cron`


### Features 
 - Create a **sql** file by each dabtase

### VAR Description
- `CURRENT_DATE`: Store current date useing YYYY-MM-DD-HH-mm-ss.
- `CMD_MYSQLDUMP`: Set full path of command `mysqldump`.
- `CMD_MYSQL`: Set full path of command `mysql`.
- `DST_BACKUP`: Establish which dir use to store logs.


## WARNING
- Unfortunately, to use this file, you need to set a username and password in the script, which represents a security breach if users have access to the server.
- The script does not validate whether an SQL backup with the same name already exists.
