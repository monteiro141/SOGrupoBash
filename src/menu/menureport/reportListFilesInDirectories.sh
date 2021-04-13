# ----------------------------------------------------- #
# Report list files in directories: Reports the
# list of files in directories
# ----------------------------------------------------- #

#option variables
count=0;
options=();
fullPath=();
#get all database files
while read line
do 
  if [[ -d "$line" ]]; then 
    count=$((count + 1));
    fullPath[$count]="$line"
    lineCut=$(echo "$line" | rev | cut -d '/' -f 1 | rev)
    options[$count]=$count" "$lineCut""
  fi
done < databases/database.db
options=(${options[@]})
#show report list files in directories menu
if [ ${#options[@]} -ne 0 ];then
  while $repeat
  do
    cmd=(dialog --keep-tite --menu "Choose an option:" 22 76 16)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
    case $? in 
      0) . ./src/menu/menureport/reportFilesInDirectories.sh "${fullPath[$choices]}";;
      1) break;;
    esac
  done
else
  dialog --title "Error" --msgbox "There are no files in the database" 0 0
fi
