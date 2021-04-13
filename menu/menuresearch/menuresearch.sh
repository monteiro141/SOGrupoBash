repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
  dialog --title "Menu" --menu "Pesquisa" 0 0 0 \
  1 "Listar Todos os Ficheiros e Diretorias"\
  2 "Listar Todos os Ficheiros Atualizados no último Backup"\
  3 "Listar Ficheiros numa Diretoria"\
  4 "Listar Ficheiros de uma Diretoria Atualizada no último Backup"\
  0 "Sair para o Menu Principal" 2> $tempfile
  opt=$?
  choice=$(cat $tempfile)
  case $opt in 
  0) 
    case $choice in
    1) . ./menu/menuresearch/ResearchListAll.sh;;
    2) . ./menu/menuresearch/ResearchLastBackup.sh;;
    3) #. ./menu/menuresearch/ResearchListDirectory.sh
    ;;
    4) #. ./menu/menuresearch/ResearchDirectoryLastBackup.sh
    ;;
    0) break;;
    esac
  ;;
  1) break;;
  esac
done