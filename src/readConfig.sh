# ----------------------------------------------------- #
# Read config: Reads the configuration and saves it to
# global variables
# ----------------------------------------------------- #

#iterate through the config file and add it to the global keys
while read line
do
  key=$(echo $line | cut -d "=" -f 1)
  if [ $key = "dbFileLocation" ];then
    #the default location for the databases
    dbFileLocation=$(echo $line | cut -d "=" -f 2)
  fi
  if [ $key = "defaultBackupDirectory" ];then
    #the default location for the backups
    backupDir=$(echo $line | cut -d "=" -f 2)
  fi
  if [ $key = "backupPeriod" ];then
    #the default backupPeriod
    backupPeriod=$(echo "$line" | cut -d "=" -f 2)
  fi
done < "config/backup.cfg"
