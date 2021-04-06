
count=0;
options=();
while read line
do 
   lineCut=$(echo "$line" | rev | cut -d '/' -f 1 | rev)
   echo "$lineCut"
   count=$((count + 1));
   options[$count]=$count" "$lineCut""
done < databases/database.db

options=(${options[@]})

if [ ${#options[@]} -ne 0 ] 
then
    while $repeat
        do
        cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)

        choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
        case $? in 
            0) #. ./reportShowPath.sh "$(sed "${choices}q;d" databases/database.db)"
            break;;
            1) break;;
        esac
    done
else
    dialog --title "Aviso" --msgbox 'Não há ficheiros/diretorias na database.db' 0 0
fi