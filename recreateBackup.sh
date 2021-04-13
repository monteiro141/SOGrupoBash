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
filemd5Sum=$(md5sum $1)
cat $dbFileLocation/backup.db | grep -v $1 > backupTemp
mv backupTemp $dbFileLocation/backup.db
ls $backupDir | grep "$fileName.tar.bz2" &> /dev/null
if [ $? -eq 0 ];then
  rm "$backupDir$fileName.tar.bz2"
fi
fType=$(file $1)
if [ $(echo $fType | cut -d " " -f 2) = "directory" ];then
  fileType="Directory"
else
  fileType="RegularFile"
fi
echo "$fileType $filemd5Sum  $(date +"%d/%m/%y|%H:%M:%S") $backupPeriod" >> "$dbFileLocation/backup.db"
tar cf "$backupDir$fileName.tar" -C $(echo $1 | rev | cut -d '/' -f 2- | rev) $(echo $1 | rev | cut -d '/' -f 1 | rev)
bzip2 "$backupDir$fileName.tar"
