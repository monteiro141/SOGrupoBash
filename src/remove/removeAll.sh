# ----------------------------------------------------- #
# Remove All: Remove all files from the database/backup
# and backup files
# ----------------------------------------------------- #

#remove database files
rm "$dbFileLocation/database.db"
touch "$dbFileLocation/database.db"
#remove backup files' registry
rm "$dbFileLocation/backup.db"
touch "$dbFileLocation/backup.db"
#remove backup files
rm -rf $backupDir
mkdir $backupDir