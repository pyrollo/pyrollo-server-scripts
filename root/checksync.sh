#!/bin/sh

DIR=$1
DAYS=$2
EMAIL=moi@pyrollo.com
SENDER=moi@pyrollo.com

if [[ "$(find $storage_dir/$DIR -mtime -$DAYS | head)" == "" ]]; then
	lastfiles=$(find $storage_dir/$DIR -printf "%T@i|%TD|%Tc\t%p\n" | sort -rn | head -n 15 | cut -d"|" -f2-)
	lastdate=$(echo "$lastfiles" | head -n 1 | cut -d"|" -f1)

	echo -e "Sync check for $DIR on last $DAYS days\n\n$DIR have not been synced since $lastdate.\n\nLast files copied:\n$(echo "$lastfiles" | cut -d"|" -f2-)\n" \
		| mail -s "No sync on $DIR since $lastdate." -r "$SENDER" "$EMAIL"

	echo "No sync on $DIR since $lastdate." 
else
	echo "Sync on $DIR within $DAYS days ok."
fi

