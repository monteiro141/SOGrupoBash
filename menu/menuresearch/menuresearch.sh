repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
  dialog --title "Menu" --menu "Pesquisa" 0 0 0 \
  1 "Listar Todos os Ficheiros e Diretorias"\
  2 "Listar Todos os Ficheiros Atualizados no último Backup"\
  3 "Listar Ficheiros numa Diretoria"\
  4 "Listar Ficheiros Atualizados de uma Diretoria"\
  0 "Sair para o Menu Principal" 2> $tempfile
  opt=$?
  choice=$(cat $tempfile)
  case $opt in 
  0) 
    case $choice in
    1) echo "1 selecionado";break;;
    2) echo "2 selecionado";break;;
    3) echo "3 selecionado";break;;
    4) echo "4 selecionado";break;;
    0) break;;
    esac
  ;;
  1) break;;
  esac
done