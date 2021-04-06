#usar $HOME como final -> usar ./ como teste nos paths
FILE=$(dialog --stdout --title "Please choose a file" --fselect ./ 14 70)
opt=$?
  case $opt in 
  0) . ./insertToDirectory.sh $(realpath $FILE)  ;;
  1) ;;
  esac
