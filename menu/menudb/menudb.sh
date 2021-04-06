repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
  dialog --title "Menu" --menu "Menu principal:" 0 0 0 \
  1 "Restaurar um Ficheiro ou Diretoria"\
  2 "Restaurar um Ficheiro ou Diretoria mas numa outra pasta (que não seja a verdadeira)" \
  3 "Recriar um ficheiro .tar e recriar-lo de acordo com o .db" 2> $tempfile
  opt=$?
  choice=$(cat $tempfile)
  case $opt in 
  0) 
    case $choice in
    1) . ./menu/menudb/restoreFile.sh;;
    2) . ./menu/menudb/restoreFileNotRealLocation.sh;;
    3) break;;
    esac
  ;;
  1) break;;
  esac
done