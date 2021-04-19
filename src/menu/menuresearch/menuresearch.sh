# ----------------------------------------------------- #
# Menu Research: Shows the research menu
# ----------------------------------------------------- #

#temp file
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
#loop control variable
repeat=true
#show menu and iterate through its options
while $repeat
do
  dialog --title "Research Menu" --menu "What do you want to do?" 0 0 0 \
  1 "Listar Todos os Ficheiros e Diretorias"\
  2 "Listar Todos os Ficheiros Atualizados no último Backup"\
  3 "Listar Ficheiros numa Diretoria"\
  4 "Listar Ficheiros de uma Diretoria Atualizada no último Backup"\
  0 "Sair para o Menu Principal" 2> $tempfile
  #OK or Cancel
  opt=$?
  #choice chosen
  choice=$(cat $tempfile)
  #choice menu
  case $opt in 
    0) 
      case $choice in
        1) . ./src/menu/menuresearch/ResearchListAll.sh;;
        2) . ./src/menu/menuresearch/ResearchLastBackup.sh;;
        3) . ./src/menu/menuresearch/ResearchListDirectory.sh
        ;;
        4) . ./src/menu/menuresearch/ResearchDirectoryLastBackup.sh
        ;;
        0) break;;
      esac;;
    1) break;;
  esac
done
