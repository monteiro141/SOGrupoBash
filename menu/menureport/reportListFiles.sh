touch tmp
while read line 
do
    if [[ -f "$line" ]]; then 
        echo "$line" >> tmp
    fi
done < databases/database.db
dialog --title "Files"  --textbox tmp 20 80
rm tmp