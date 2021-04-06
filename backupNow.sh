ls $dbFileLocation | grep -q backup.db

if [ $? -eq 1 ];then
  touch "$dbFileLocation/backup.db"
fi

ls $backupDir 2> /dev/null
if [ $? -eq 2 ];then
  mkdir $backupDir
fi

while read lineDB
do
  fileName=$(echo $lineDB | rev | cut -d "/" -f 1 | rev)
  filemd5Sum=$(md5sum $lineDB)
  alreadyThere="false"
  while read lineBackup
  do
    if [ $(echo "$lineBackup" | cut -d " " -f 2) = $(echo "$filemd5Sum" | cut -d " " -f 1) ];then
      alreadyThere="true"
    fi
  done < "$dbFileLocation/backup.db"
  if [ $alreadyThere = "false" ];then
    cat $dbFileLocation/backup.db | grep -v $lineDB > backupTemp
    mv backupTemp $dbFileLocation/backup.db
    ls $backupDir | grep "$fileName.tar.bz2"
    if [ $? -eq 0 ];then
      rm "$backupDir$fileName.tar.bz2"
    fi
    if [ $(echo $lineDB | cut -d " " -f 2) = "directory" ];then
      fileType="Directory"
    else
      fileType="RegularFile"
    fi
    echo "$fileType $filemd5Sum  $(date +"%d/%m/%y|%H:%M:%S") $backupPeriod" >> "$dbFileLocation/backup.db"
    tar cf "$backupDir$fileName.tar" -C $(echo $lineDB | rev | cut -d '/' -f 2- | rev) $(echo $lineDB | rev | cut -d '/' -f 1 | rev)
    bzip2 "$backupDir$fileName.tar"
    echo "$(date +"%d/%m/%y|%H:%M:%S")" > lastBackup
  fi
done < "$dbFileLocation/database.db"