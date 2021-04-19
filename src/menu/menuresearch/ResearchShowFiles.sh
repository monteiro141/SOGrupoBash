# ----------------------------------------------------- #
# Report show Files: Show the files of a directory
# ----------------------------------------------------- #
echo "$1" > tmp1
ls $1 >> tmp1
dialog --title "Full Path and Files/Directories" --textbox tmp1 0 0
rm tmp1