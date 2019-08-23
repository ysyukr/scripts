#!/bin/sh
# Get system date
sysdtime=`date +%Y%m%d`;

# Make datename(YYYYMMDD) folder
mkdir -p /backup/dbdump/${sysdtime};

# DB admin password
db_passwd="********";

# Dump italo databases
/usr/bin/mysqldump -uroot -p"$db_passwd" --routines --trigger --database test > /backup/dbdump/${sysdtime}/test_backup.sql