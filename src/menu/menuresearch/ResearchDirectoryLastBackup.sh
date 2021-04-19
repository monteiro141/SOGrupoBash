# ----------------------------------------------------- #
# Research list directory: Research the list directory
# ----------------------------------------------------- #

#option variables
count=0;
options=();
fullPath=();
#get the date of last backup
lastbackup="$(cat lastBackup)"
#get all backup files
while read line
do 
  directory=$(echo "$line" | cut -d ' ' -f 1)
  if [ "$directory" = "Directory"  ]
  then
    backupdate=$(echo "$line" | cut -d ' ' -f 6)
    if [ "$lastbackup" = "$backupdate" ]
    then
        count=$((count + 1));
        fullPath[$count]="$(echo "$line" | cut -d ' ' -f 4)"
        lineCut=$(echo "$line" | cut -d ' ' -f 4 | rev | cut -d '/' -f 1 | rev)
        options[$count]=$count" "$lineCut""
    fi
  fi
done < databases/backup.db
options=(${options[@]})
#show research list directory menu
if [ ${#options[@]} -ne 0 ];then
  while $repeat
  do
    cmd=(dialog --keep-tite --menu "Choose an option:" 22 76 16)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
    case $? in 
      0) . ./src/menu/menuresearch/ResearchShowFiles.sh "${fullPath[$choices]}";;
      1) break;;
    esac
  done
else
  dialog --title "Error" --msgbox "There are no files in the database" 0 0
fi
