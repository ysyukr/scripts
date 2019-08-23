#!/bin/sh
# Get system date
sysdtime=`date +%Y%m%d`;

# Calculate date
prev_date=`date --date '6 days ago' +"%Y%m%d"`;

# Delete old file
rm -rf /backup/dbdump/${prev_date};