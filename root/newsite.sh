#!/bin/sh

usage() {
  echo "newsite.sh sitename"
  echo "sitename : nom du site côté serveur (example.com)"
}

wwwuser=www-data
wwwroot=/data/www

if [ $# -ne 1 ]; then
  usage
  exit
fi

sitename=$1
groupname=www-$sitename
sitedir=$wwwroot/$sitename

if [ ! -e $sitedir ]; then
  echo "Creating $sitedir"
  mkdir $sitedir
else
  echo "Reusing $sitedir"
fi

if [ ! -d $sitedir ]; then
  echo "Error $sitedir is not a directory !"
  exit 1
fi

echo "Creating basic directory structure"
mkdir -p $sitedir/htdocs
mkdir -p $sitedir/logs
mkdir -p $sitedir/stats

echo "Creating group $groupname"
groupadd $groupname

echo "Changing ownership and permissions of $sitedir"
chown -R $wwwuser:$groupname $sitedir
find $sitedir -type d -exec chmod 2770 {} \;
find $sitedir -type f -exec chmod 0660 {} \;

echo "Adding group to main users"
usermod -a -G $groupname www-backup
usermod -a -G $groupname pyrollo
usermod -a -G $groupname $wwwuser