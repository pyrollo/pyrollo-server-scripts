#!/bin/sh

wwwroot=/data/www
conffile=$wwwroot/conf/dbdump.conf

if [[ -z "$dbuser" ]] 
then
	echo "dbuser env var not set."
	echo "Aborting."
	exit 1
fi

if [[ -z "$dbpwd" ]]
then
	echo "dbpwd env var not set."
	echo "Aborting."
	exit 1
fi

if [ ! -r "$conffile" ]
then
	echo "Configuration file $conffile not readable."
	echo "Aborting."
	exit 1
fi

log() {
  echo `date +"%Y-%m-%d %H:%M:%S"` $@
}

dump_db() {
	log Start dumping database $1.
	mysqldump -u $dbuser -p$dbpwd $1 -r $2/$1.sql
	gzip -f $2/$1.sql
	log Finished dumping database $1.
}

log Start dumping databases.

while read line
do
	if [[ "$line" =~ ^(.*)# ]]
	then
		line=${BASH_REMATCH[1]}
	fi

	if [[ "$line" =~ ^[[:space]]*(.*)[[:space:]]*$ ]]
	then
		line=${BASH_REMATCH[1]}
	fi
	
	if [[ -z "$line" ]]
	then
		continue
	fi

	if [[ "$line" =~ ^(.+)[[:space:]]+(.+)$ ]]
	then
		dump_db ${BASH_REMATCH[1]} ${BASH_REMATCH[2]}
	else
		echo "Error in $conffile in following line:"
		echo "$line"
	fi

done < "$conffile"

log Finished databases dump.
