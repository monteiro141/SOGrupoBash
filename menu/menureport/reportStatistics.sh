#SOGrupoBash ->du -hs /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash
#158K    /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash
#SOGrupoBash ->du -hs /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash/crontab.sh
#4.0K    /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash/crontab.sh
#Lembrar -> espaço medio por ficheiro
count=0;
options=();
fullPath=();
while read line
do 
        count=$((count + 1));
        fullPath[$count]="$line"
        lineCut=$(echo "$line" | rev | cut -d '/' -f 1 | rev)
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
            0) #. ./menu/menureport/reportShowPath.sh "${fullPath[$choices]}"
               break;;
            1) break;;
        esac
    done
else
    dialog --title "Aviso" --msgbox 'Não há ficheiros/diretorias na database.db' 0 0
fi