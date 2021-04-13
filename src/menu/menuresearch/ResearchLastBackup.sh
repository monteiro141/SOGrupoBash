# ----------------------------------------------------- #
# Research last backup: Research the last backup
# ----------------------------------------------------- #

#option variables
count=0;
options=();
fullPath=();
dateLastBackUp="$(cat lastBackup)";
#get all backup files
while read line
do 
  if [ "$(echo "$line" | cut -d ' ' -f 6)" = "$dateLastBackUp" ]; then
    count=$((count + 1));
    fullPath[$count]="$(echo "$line" | cut -d ' ' -f 4)"
    lineCut=$(echo "$line" | cut -d ' ' -f 4 | rev | cut -d '/' -f 1 | rev)
    options[$count]=$count" "$lineCut""
  fi
done < databases/backup.db
options=(${options[@]})
#show research last backup menu
if [ ${#options[@]} -ne 0 ];then
  while $repeat
  do
    cmd=(dialog --keep-tite --menu "Choose an option:" 22 76 16)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
    case $? in 
      0) . ./src/menu/menureport/reportShowPath.sh "${fullPath[$choices]}";;
      1) break;;
    esac
  done
else
  dialog --title "Error" --msgbox "There are no files in the database" 0 0
fi
