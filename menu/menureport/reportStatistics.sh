#SOGrupoBash ->du -hs /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash
#158K    /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash
#SOGrupoBash ->du -hs /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash/crontab.sh
#4.0K    /mnt/c/Users/monte/OneDrive/Documentos/SistemasOperativos/SOGrupoBash/crontab.sh
#Lembrar -> espaço medio por ficheiro
count=0;
espaco=0;
media=0;
options=();
fullPath=();
while read line
do
    count=$((count + 1))
    strg="$(du -ks $line | sed -r 's/([[:space:]]+).*/\1/')" #du devolve TTamanho em Kbs e o path, sed para tirar o path
    espaco="$( bc <<<"$espaco + $strg")"
done < databases/database.db

if [ $count -ne 0 ] 
then
media=$((espaco / count))
echo "Numero de ficheiros: $count" > tmp.txt
echo "Espaço total ocupado pelos ficheiros: $espaco KB" >> tmp.txt
echo "Media ocupada pelos ficheiros: $media KB" >> tmp.txt
        dialog \
        --title 'Estatistica' \
         --textbox tmp.txt 0 0
else
    dialog --title "Aviso" --msgbox 'Não há ficheiros/diretorias na database.db' 0 0
fi
rm tmp.txt