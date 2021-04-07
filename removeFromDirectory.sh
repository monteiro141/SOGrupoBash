while read lineDB
do
  if [ "$lineDB" = "$1" ];then
    cat "$dbFileLocation/database.db" | grep -vw ^$1$ > databaseTemp
    mv databaseTemp "$dbFileLocation/database.db"
    break
  fi
done < "$dbFileLocation/database.db"

touch backupTemp
while read lineBackup
do
  if [[ "$(echo $lineBackup | cut -d ' ' -f 3)" = "$1" ]];then
    backupFileName=$(echo $lineBackup | cut -d ' ' -f 3 | rev | cut -d '/' -f 1 | rev)
    rm -rf "$backupDir$backupFileName.tar.bz2"
  else
    echo "$lineBackup" >> backupTemp
  fi
done < "$dbFileLocation/backup.db"
mv backupTemp "$dbFileLocation/backup.db"
rm lastBackup &> /dev/null
touch lastBackup &> /dev/null