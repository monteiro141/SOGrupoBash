# ----------------------------------------------------- #
# Insert File: Show the menu to choose the file
# to insert to the database
# ----------------------------------------------------- #

#menu to choose a file to track
FILE=$(dialog --stdout --title "Please choose a file to track" --fselect ./ 14 70)
#choice menu
case $? in 
  0) . ./src/insert/insertToDirectory.sh $(realpath $FILE);;
  1) ;;
esac
