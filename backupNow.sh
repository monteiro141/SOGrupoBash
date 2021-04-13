ls $dbFileLocation | grep -q backup.db

if [ $? -eq 1 ];then
  touch "$dbFileLocation/backup.db"
fi

ls $backupDir &> /dev/null
if [ $? -eq 2 ];then
  mkdir $backupDir
fi

ls $dbFileLocation &> /dev/null
if [ $? -eq 2 ];then
  mkdir $dbFileLocation
fi

CURRENT_DATE=$(date +"%d/%m/%y|%H:%M:%S")

DIALOG=${DIALOG=dialog}
let a=$(wc -l "$dbFileLocation/database.db" | cut -d ' ' -f 1)
COUNT=`expr 100 / $a`
(
while read lineDB
do
  echo $COUNT
  fileName=$(echo $lineDB | rev | cut -d "/" -f 1 | rev)
  fType=$(file $lineDB)
  if [ $(echo $fType | cut -d " " -f 2) = "directory" ];then
    fileType="Directory"
  else
    fileType="RegularFile"
  fi
  if [ $fileType = "RegularFile" ];then
    filemd5Sum=$(md5sum $lineDB)
  else
    filemd5Sum="$(find $lineDB -type f -exec md5sum {} \; | md5sum | cut -d ' ' -f 1)  $lineDB"
  fi
  alreadyThere="false"
  while read lineBackup
  do
    if [ $(echo "$lineBackup" | cut -d " " -f 2) = $(echo "$filemd5Sum" | cut -d " " -f 1) ];then
      alreadyThere="true"
    fi
  done < "$dbFileLocation/backup.db"
  if [ $alreadyThere = "false" ];then
    ls $backupDir | grep -q "$fileName.tar.bz2"
    if [ $? -eq 0 ];then
      rm "$backupDir$fileName.tar.bz2"
    fi
    echo "$fileType $filemd5Sum  $CURRENT_DATE $backupPeriod" >> "$dbFileLocation/backup.db"
    
    tar cf "$backupDir$fileName.tar" -C $(echo $lineDB | rev | cut -d '/' -f 2- | rev) $(echo $lineDB | rev | cut -d '/' -f 1 | rev)
    bzip2 "$backupDir$fileName.tar"
    echo "$CURRENT_DATE" > lastBackup
  fi
  COUNT=`expr $COUNT + 100 / $a`
done < "$dbFileLocation/database.db"
) | $DIALOG --title "Backing up your files" --gauge "BACKING UP..." 20 70 0