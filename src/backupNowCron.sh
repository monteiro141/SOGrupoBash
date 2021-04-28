# ----------------------------------------------------- #
# Backup now cron: Backs up the changed tracked files
# ----------------------------------------------------- #

#check if the database folder exists. Create it if it doesn't
ls $dbFileLocation &> /dev/null
if [ $? -eq 2 ];then
  mkdir $dbFileLocation
fi
#check if the backup folder exists. Create it if it doesn't
ls $backupDir &> /dev/null
if [ $? -eq 2 ];then
  mkdir $backupDir
fi
#check if the database exists. Create it if it doesn't
ls $dbFileLocation | grep -q database.db
if [ $? -eq 1 ];then
  touch "$dbFileLocation/database.db"
fi
#check if the backup registry exists. Create it if it doesn't
ls $dbFileLocation | grep -q backup.db
if [ $? -eq 1 ];then
  touch "$dbFileLocation/backup.db"
fi
#get current date
CURRENT_DATE=$(date +"%d/%m/%y|%H:%M:%S")

while read lineDB
do
  #get filename
  fileName=$(echo $lineDB | rev | cut -d "/" -f 1 | rev)
  echo $COUNT
  echo "XXX"
  echo "Backing up $fileName"
  echo "XXX"
  #get file type
  fType=$(file $lineDB)
  if [ $(echo $fType | cut -d " " -f 2) = "directory" ];then
    fileType="Directory"
  else
    fileType="RegularFile"
  fi
  #get md5sum
  if [ $fileType = "RegularFile" ];then
    filemd5Sum=$(md5sum $lineDB)
  else
    filemd5Sum="$(find $lineDB -type f -exec md5sum {} \; | md5sum | cut -d ' ' -f 1)  $lineDB"
  fi
  #check if file is already backed up and haven't changed
  alreadyThere="false"
  while read lineBackup
  do
    if [ $(echo "$lineBackup" | cut -d " " -f 2) = $(echo "$filemd5Sum" | cut -d " " -f 1) ];then
      alreadyThere="true"
    fi
  done < "$dbFileLocation/backup.db"
  #backup file
  if [ $alreadyThere = "false" ];then
    #remove backup if it's already there
    ls $backupDir | grep -q "$fileName.tar.bz2"
    if [ $? -eq 0 ];then
      rm "$backupDir$fileName.tar.bz2"
    fi
    #register backup
    echo "$fileType $filemd5Sum  $CURRENT_DATE $backupPeriod" >> "$dbFileLocation/backup.db"
    #tar and zip the file
    tar cf "$backupDir$fileName.tar" -C $(echo $lineDB | rev | cut -d '/' -f 2- | rev) $(echo $lineDB | rev | cut -d '/' -f 1 | rev)
    bzip2 "$backupDir$fileName.tar"
    #register the date of the backup
    echo "$CURRENT_DATE" > lastBackup
  fi
  COUNT=`expr $COUNT + 100 / $loadingBarInc`
done < "$dbFileLocation/database.db"

