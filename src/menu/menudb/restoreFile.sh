# ----------------------------------------------------- #
# Restore File Menu: Show the Restore File Menu and
# choose its options
# ----------------------------------------------------- #

#option variables
count=0;
options=();
#get all backed up files
ls backup/ > tmp
while read line
do 
  count=$((count + 1));
  options[$count]=$count" "$line""
done < tmp
options=(${options[@]})
#restore file menu
if [ ${#options[@]} -ne 0 ];then
  while $repeat
    do
    cmd=(dialog --keep-tite --menu "Choose an option:" 22 76 16)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
    case $? in 
      0) . ./src/menu/menudb/restore.sh "$(sed "${choices}q;d" tmp)" h
      break;;
      1) break;;
    esac
  done
else
  dialog --title "Error" --msgbox "There are no files in backup" 0 0
fi
rm tmp