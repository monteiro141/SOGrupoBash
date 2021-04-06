repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
  dialog --title "Menu" --menu "Menu Relatório:" 0 0 0 \
  1 "Listar Todos os Ficheiros e Diretorias"\
  2 "Listar Ficheiros apenas (sem estar numa Diretoria)"\
  3 "Listar Diretorias apenas"\
  4 "Listar Ficheiros numa Diretoria"\
  5 "Estatísticas (#Ficheiros, Espaço Ocupado etc)"\
  0 "Sair para o menu principal" 2> $tempfile
  opt=$?
  choice=$(cat $tempfile)
  case $opt in 
  0) 
    case $choice in
    1) ./menu/menureport/reportList.sh;;
    2) ./menu/menureport/reportListFiles.sh;;
    3) ./menu/menureport/reportListDirectories.sh;;
    4) ./menu/menureport/reportListFilesInDirectories.sh;;
    5) ./menu/menureport/reportStatistics.sh;;
    0) break;;
    esac
  ;;
  1) break;;
  esac
done