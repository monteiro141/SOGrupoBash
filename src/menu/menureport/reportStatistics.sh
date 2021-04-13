# ----------------------------------------------------- #
# Report Statistics: Show statistics about the files
# ----------------------------------------------------- #

#option variables
count=0;
espaco=0;
media=0;
options=();
fullPath=();
#get all database files
while read line
do
  count=$((count + 1))
  strg="$(du -ks $line | sed -r 's/([[:space:]]+).*/\1/')"
  espaco="$( bc <<<"$espaco + $strg")"
done < databases/database.db

if [ $count -ne 0 ];then
  media=$((espaco / count))
  echo "Number of files: $count" > tmp.txt
  echo "Total occupied space: $espaco KB" >> tmp.txt
  echo "Mean occupied space: $media KB" >> tmp.txt
          dialog \
          --title 'Statistics' \
           --textbox tmp.txt 0 0
else
  dialog --title "Error" --msgbox "There are no files in the database" 0 0
fi
rm tmp.txt
