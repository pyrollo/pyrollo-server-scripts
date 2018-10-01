#!/bin/sh

dbuser=root
dbpwd=<dbpassword>

execmysql()
{
  output=$(mysql -u $dbuser -p$dbpwd 2>&1 <<_ENDOFQUERY_
$1;
exit
_ENDOFQUERY_
 )

  err=$?
  if [ "$err" -ne "0" ]; then
    echo "Mysql returned error $err"
    echo $output
    exit $err
  fi
}

# Check executables
command -v pwgen >/dev/null 2>&1 || { echo >&2 "pwgen not installed but needed"; exit 1; }
command -v mysql >/dev/null 2>&1 || { echo >&2 "mysql not installed but needed"; exit 1; }

# Check parameters
if [ "$1" = "-q" ]; then
  exec 3>&1
  exec 1>/dev/null
  newdbname=$2
else
  exec 3>/dev/null
  newdbname=$1
fi
if [ -z $newdbname ]; then
    echo "Usage : $0 [-q] dbname"
    exit 1
fi

# Generate a password
newpwd=$(pwgen -s 20 1)

# Create the database
execmysql "create database $newdbname"
echo "Database $newdbname created."

# Create the corresponding user
execmysql "grant all on $newdbname.* to '$newdbname'@localhost identified by '$newpwd'"
echo "User $newdbname created."
echo "Password for $newdbname : $newpwd"
echo >&3 $newpwd
exit 0