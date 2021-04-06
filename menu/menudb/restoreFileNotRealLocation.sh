


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
            0)FILE=$(dialog --stdout --title "Please choose a path" --fselect ./ 14 70);
                if [ -d "$FILE" ]
                then 
                    . ./menu/menudb/restore.sh "$(sed "${choices}q;d" tmp)" o "$(realpath $FILE)"
                fi
                break;;
            1) break;;
        esac
    done
else
    dialog --title "Aviso" --msgbox 'Não há ficheiros/diretorias no backup' 0 0
fi
rm tmp