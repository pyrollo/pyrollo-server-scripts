# pyrollo-server-scripts
These are my personnal server scripts. Feel free to reuse.

## Sites structures
All sites are suposed to have the same directory structure :
  /data/www/(directory)
    /htdocs : site's files
    /logs : site's log files
    /stats : webalizer stats (if any)

# Root
These scripts should be placed in a safe directory, only readable by root or admin user.

## newsite.sh
Creates a new site directory.

  newsite.sh <sitename>

## newdatabase.sh
Creates a new database.

  newdatabase.sh [-q] <dbname>

-q : quiet output, used for automation

## dump-databases.sh
Backup script. It dumps databases into site directory so database dumps can be backuped with the site. Also usefull for previous day database recovery.

## backup-files.sh
Backups some directories in the /data/www/backup directory.