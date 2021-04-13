# ----------------------------------------------------- #
# Main Menu: Show the main menu and choose its options
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
ls $dbFileLocation | grep -q backup.db
if [ $? -eq 1 ];then
  touch "$dbFileLocation/backup.db"
fi
#get filename
fileName=$(echo $1 | rev | cut -d "/" -f 1 | rev)
#get file type
fType=$(file $1)
if [ $(echo $fType | cut -d " " -f 2) = "directory" ];then
  fileType="Directory"
else
  fileType="RegularFile"
fi
#get md5sum
if [ $fileType = "RegularFile" ];then
    filemd5Sum=$(md5sum $1)
else
  filemd5Sum="$(find $1 -type f -exec md5sum {} \; | md5sum | cut -d ' ' -f 1)  $1"
fi
#iterate through the backup file and recreate the backup
while read lineBackup
do
  if [[ "$(echo "$lineBackup" | cut -d ' ' -f 4)" = "$1" ]];then
    #rebackup file
    echo "$fileType $filemd5Sum  $(date +"%d/%m/%y|%H:%M:%S") $backupPeriod" >> bTemp
    ls $backupDir | grep "$fileName.tar.bz2" &> /dev/null
    if [ $? -eq 0 ];then
      rm "$backupDir$fileName.tar.bz2"
    fi
    #tar and zip file
    tar cf "$backupDir$fileName.tar" -C $(echo $1 | rev | cut -d '/' -f 2- | rev) $(echo $1 | rev | cut -d '/' -f 1 | rev)
    bzip2 "$backupDir$fileName.tar"
  else
    #already there file
    echo "$lineBackup" >> bTemp
  fi
done < "$dbFileLocation/backup.db"
mv bTemp "$dbFileLocation/backup.db"