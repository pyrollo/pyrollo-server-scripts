#!/bin/sh

# This scripts copies some directories to a place backuped nightly

# Destination directory
backup=/data/www/backup

log() {
  echo `date +"%Y-%m-%d %H:%M:%S"` $@
}

copy() {
  rm -rf $2
  mkdir -p `dirname $2`
  cp -Pr --preserve=timestamps $1 $2
}

log Start backuping files.

# Copies some directories to the backuped dir
copy /etc/apache2 $backup/etc/apache2 # Apache config
#copy /etc/awstats $backup/etc/awstats # Awstats config
#copy /etc/webalizer $backup/etc/webalizer # Webalizer config
copy /root/scripts $backup/scripts # Root scripts (including this one)

log Finished files backup.