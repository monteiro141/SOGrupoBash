. ./readConfig.sh
repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
  dialog --title "Menu" --menu "Menu principal:" 0 0 0 \
  1 "Inserir Ficheiro e Diretorias"\
  2 "Remover Ficheiro e Diretorias"\
  3 "Alterar Periodicidade de Backup"\
  4 "Pesquisas"\
  5 "Relatórios"\
  6 "Gestão de Base de Dados"\
  8 "About"\
  9 "Fazer Backup Agora"\
  0 "Sair do Programa" 2> $tempfile
  opt=$?
  choice=$(cat $tempfile)
  case $opt in 
  0) 
    case $choice in
    1) . ./insertFile.sh;;
    2) . ./removeFile.sh;;
    3) . ./crontab.sh;;
    4) . ./menu/menuresearch/menuresearch.sh;;
    5) . ./menu/menureport/menureport.sh;;
    6) . ./menu/menudb/menudb.sh;;
    8) . ./about.sh;;
    9) . ./backupNow.sh;;
    0) break;;
    esac
  ;;
  1) break;;
  esac
done