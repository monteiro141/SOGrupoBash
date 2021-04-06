ls $dbFileLocation | grep -q database.db

if [ $? -eq 1 ];then
  touch "$dbFileLocation/database.db"
fi

ls $dbFileLocation &> /dev/null

if [ $? -eq 2 ];then
  mkdir $dbFileLocation
fi

exists=false
while read lineDB
do
  if [ "$lineDB" = $1 ];then
    exists=true
    break
  fi
done < "$dbFileLocation/database.db"

if [ $exists = "false" ];then
  echo $1 >> "$dbFileLocation/database.db"
else
  echo "ERROR MODIFICAR LOL"
fi
