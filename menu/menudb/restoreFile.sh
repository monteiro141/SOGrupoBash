count=0;
options=();
ls backup/ > tmp
while read line
do 
    count=$((count + 1));
    options[$count]=$count" "$line""
done < tmp


options=(${options[@]})

if [ ${#options[@]} -ne 0 ] 
then
    while $repeat
        do
        cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)

        choices=$("${cmd[@]}" "${options[@]}" 2>&1 > /dev/tty)
        case $? in 
            0) . ./menu/menudb/restore.sh "$(sed "${choices}q;d" tmp)" h
            break;;
            1) echo "1"; break;;
        esac
    done
else
    dialog --title "Aviso" --msgbox 'Não há ficheiros/diretorias no backup' 0 0
fi
rm tmp