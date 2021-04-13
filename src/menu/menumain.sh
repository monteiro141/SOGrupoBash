# ----------------------------------------------------- #
# Main Menu: Show the main menu and choose its options
# ----------------------------------------------------- #

#read default variables from the config file
. ./src/readConfig.sh
#temp file
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
#loop control variable
repeat=true
#show menu and iterate through its options
while $repeat
do
  #menu options in portuguese to follow up on the default menu options provided
  dialog --title "Main Menu" --menu "What do you want to do?" 0 0 0 \
  1 "Inserir Ficheiro e Diretorias"\
  2 "Remover Ficheiro e Diretorias"\
  3 "Alterar Periodicidade de Backup"\
  4 "Pesquisas"\
  5 "Relatórios"\
  6 "Gestão de Base de Dados"\
  8 "About"\
  9 "Fazer Backup Agora"\
  0 "Sair do Programa" 2> $tempfile
  #OK or Cancel
  opt=$?
  #choice chosen
  choice=$(cat $tempfile)
  #choice menu
  case $opt in 
    0) 
      case $choice in
        1) . ./src/insert/insertFile.sh;;
        2) . ./src/remove/removeFile.sh;;
        3) . ./src/crontab.sh;;
        4) . ./src/menu/menuresearch/menuresearch.sh;;
        5) . ./src/menu/menureport/menureport.sh;;
        6) . ./src/menu/menudb/menudb.sh;;
        8) . ./src/about.sh;;
        9) . ./src/backupNow.sh;;
        0) break;; #exit the program
      esac;;
    1) 
      break;; #exit the program
  esac
done