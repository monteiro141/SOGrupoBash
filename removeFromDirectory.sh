while read lineDB
do
  if [ "$lineDB" = "$1" ];then
    cat "$dbFileLocation/database.db" | grep -vw $1 > databaseTemp
    mv databaseTemp "$dbFileLocation/database.db"
    break
  fi
done < "$dbFileLocation/database.db"

while read lineBackup
do
  if [[ "$lineBackup" = *"$1"* ]];then
    cat "$dbFileLocation/backup.db" | grep -vw $1 > backupTemp
    backupFileName=$(echo $lineBackup | cut -d ' ' -f 3 | rev | cut -d '/' -f 1 | rev)
    echo "$backupDir$backupFileName"
    rm -rf "$backupDir$backupFileName.tar.bz2"
    mv backupTemp "$dbFileLocation/backup.db"
    break
  fi
done < "$dbFileLocation/backup.db"
