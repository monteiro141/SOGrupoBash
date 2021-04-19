# ----------------------------------------------------- #
# Insert File to Directory: Track a file, inserting it
# into the database
# ----------------------------------------------------- #

#check if the database folder exists. Create it if it doesn't
ls $dbFileLocation &> /dev/null
if [ $? -eq 2 ];then
  mkdir $dbFileLocation
fi
#check if the database exists. Create it if it doesn't 
ls $dbFileLocation | grep -q database.db
if [ $? -eq 1 ];then
  touch "$dbFileLocation/database.db"
fi
#check if file is already being tracked
exists=false
while read lineDB
do
  if [ "$lineDB" = "$1" ];then
    exists=true
    break
  fi
done < "$dbFileLocation/database.db"
ls $1 &> /dev/null
if [ $? -eq 2 ];then
  dialog --title "Error" --clear --msgbox "That file doesn't exist!" 5 40
else
  #track file if it isn't being tracked yet
  if [ $exists = "false" ];then
    echo "$1" >> "$dbFileLocation/database.db"
  else
    dialog --title "Error" --clear --msgbox "That file is already being tracked!" 5 40
  fi
fi
