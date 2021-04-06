while read line
do
  key=$(echo $line | cut -d "=" -f 1)
  if [ $key = "dbFileLocation" ];then
    dbFileLocation=$(echo $line | cut -d "=" -f 2)
  fi
  if [ $key = "defaultBackupDirectory" ];then
    backupDir=$(echo $line | cut -d "=" -f 2)
  fi
  if [ $key = "backupPeriod" ];then
    backupPeriod=$(echo "$line" | cut -d "=" -f 2)
  fi
  #add more keys
done < "config/backup.cfg"
