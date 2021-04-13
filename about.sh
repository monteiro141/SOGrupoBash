DIALOG=${DIALOG=dialog}
$DIALOG --title "About" --clear --msgbox "Trabalho de Sistemas Operativos\nAno Letivo: 2020/2021\nRealização por: \nBruno Monteiro,     a43994\nAlexandre Monteiro, a44149\nDuarte Arribas,     a44585" 10 35
case $? in
  0) echo "Yes chosen.";;
  1) echo "No chosen.";;
esac
