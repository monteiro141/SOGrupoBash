# ----------------------------------------------------- #
# Remove File Menu: Show the remove file menu and choose
# its options
# ----------------------------------------------------- #

#option variables
count=0;
options=();
#initialization
count=$((count + 1));
options[$count]=$count" "RemoveAll""
#get all tracked files
while read line
do 
  count=$((count + 1));
  options[$count]=$count" "$line""
done < "$dbFileLocation/database.db"
options=(${options[@]})
#remove file menu
if [ ${#options[@]} -ne 0 ];then
  while $repeat
  do
    cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)  
    case $? in 
      0)  
        if [ $choices -ne 1 ];then
          choices=$((choices - 1));
          . ./src/remove/removeFromDirectory.sh "$(sed "${choices}q;d" databases/database.db)"
        else
          . ./src/remove/removeAll.sh
        fi
        break;;
      1) break;;
    esac
  done
else
  dialog --title "Error" --msgbox "There are no files in the database!" 0 0
fi
