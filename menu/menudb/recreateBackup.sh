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

fileName=$(echo $1 | rev | cut -d "/" -f 1 | rev)
fType=$(file $1)
if [ $(echo $fType | cut -d " " -f 2) = "directory" ];then
  fileType="Directory"
else
  fileType="RegularFile"
fi
if [ $fileType = "RegularFile" ];then
    filemd5Sum=$(md5sum $1)
else
  filemd5Sum="$(find $1 -type f -exec md5sum {} \; | md5sum | cut -d ' ' -f 1)  $1"
fi

while read lineBackup
do
  if [[ "$(echo "$lineBackup" | cut -d ' ' -f 4)" = "$1" ]];then
    echo "$fileType $filemd5Sum  $(date +"%d/%m/%y|%H:%M:%S") $backupPeriod" >> bTemp
    ls $backupDir | grep "$fileName.tar.bz2" &> /dev/null
    if [ $? -eq 0 ];then
      rm "$backupDir$fileName.tar.bz2"
    fi
    tar cf "$backupDir$fileName.tar" -C $(echo $1 | rev | cut -d '/' -f 2- | rev) $(echo $1 | rev | cut -d '/' -f 1 | rev)
    bzip2 "$backupDir$fileName.tar"
  else
    echo "$lineBackup" >> bTemp
  fi
done < "$dbFileLocation/backup.db"
mv bTemp "$dbFileLocation/backup.db"