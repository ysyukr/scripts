#!/bin/sh
# Get system date
sysdtime=`date +%Y%m%d`;

# Calculate date
prev_date=`date --date '6 days ago' +"%Y%m%d"`;

# Make datename(YYYYMMDD) folder
mkdir -p /root/diskstat/${sysdtime};

# Change folder
cd /root/diskstat/${sysdtime};

# Check Disk
df -Th > disk-${sysdtime}.txt;

# mail send
mutt -s "Today's storage capacity"  ysyukr@gmail.com < /backup/diskstat/message.txt -a /backup/diskstat/${sysdtime}/disk-${sysdtime}.txt

# Delete old file
rm -rf /root/diskstat/${prev_date};