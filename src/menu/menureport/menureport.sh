# ----------------------------------------------------- #
# Menu Report: Shows the report menu
# ----------------------------------------------------- #

#temp file
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
#loop control variable
repeat=true
#show menu and iterate through its options
while $repeat
do
  dialog --title "Report Menu" --menu "What do you want to do?" 0 0 0 \
  1 "Listar Todos os Ficheiros e Diretorias"\
  2 "Listar Ficheiros apenas (sem estar numa Diretoria)"\
  3 "Listar Diretorias apenas"\
  4 "Listar Ficheiros numa Diretoria"\
  5 "Estatísticas (#Ficheiros, Espaço Ocupado etc)"\
  0 "Sair para o menu principal" 2> $tempfile
  #OK or Cancel
  opt=$?
  #choice chosen
  choice=$(cat $tempfile)
  #choice menu
  case $opt in 
    0) 
      case $choice in
      1) ./src/menu/menureport/reportList.sh;;
      2) ./src/menu/menureport/reportListFiles.sh;;
      3) ./src/menu/menureport/reportListDirectories.sh;;
      4) ./src/menu/menureport/reportListFilesInDirectories.sh;;
      5) ./src/menu/menureport/reportStatistics.sh;;
      0) break;;
      esac;;
    1) break;;
  esac
done
