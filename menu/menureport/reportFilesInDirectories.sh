ls -A $1 > tmp
dialog --title "Files" --textbox tmp 20 80
rm tmp