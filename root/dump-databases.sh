#!/bin/sh

wwwroot=/data/www
dbuser=root
dbpwd=<dbpassword>

log() {
  echo `date +"%Y-%m-%d %H:%M:%S"` $@
}

dump_db() {
  log Start dumping database $1.
  mysqldump -u $dbuser -p$dbpwd $1 -r $wwwroot/$2/$1.sql
  gzip -f $wwwroot/$2/$1.sql
  log Finished dumping database $1.
}

log Start dumping databases.

# Add here one line per database to export
dump_db <dbname> <dirname>
dump_db <dbname> <dirname>

log Finished databases dump.