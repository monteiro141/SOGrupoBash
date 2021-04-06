touch tmp
while read line 
do
    if [[ -d "$line" ]]; then 
        echo "$line" >> tmp
    fi
done < databases/database.db
dialog --title "Report"  --textbox tmp 20 80
rm tmp