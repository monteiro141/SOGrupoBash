# ----------------------------------------------------- #
# Menu DB: Show the database menu
# ----------------------------------------------------- #

#temp file
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
#loop control variable
repeat=true
#show menu and iterate through its options
while $repeat
do
  #menu options in portuguese to follow up on the default menu options provided
  dialog --title "Database Menu" --menu "What do you want to do?" 0 0 0 \
  1 "Restaurar um Ficheiro ou Diretoria"\
  2 "Restaurar um Ficheiro ou Diretoria mas numa outra pasta (que não seja a verdadeira)" \
  3 "Recriar um ficheiro .tar e recriar-lo de acordo com o .db" 2> $tempfile
  #OK or Cancel
  opt=$?
  #choice chosen
  choice=$(cat $tempfile)
  #choice menu
  case $opt in 
    0) 
      case $choice in
        1) . ./src/menu/menudb/restoreFile.sh;;
        2) . ./src/menu/menudb/restoreFileNotRealLocation.sh;;
        3) . ./src/menu/menudb/recreateBackupMenu.sh;;
      esac;;
    1) break;;
  esac
done