rm "$dbFileLocation/database.db"
touch "$dbFileLocation/database.db"
rm "$dbFileLocation/backup.db"
touch "$dbFileLocation/backup.db"
rm -rf $backupDir
mkdir $backupDir