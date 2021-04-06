if [ $2 = "h" ];then
  while read lineDB
  do
    if [ "$(echo $1 | rev | cut -d '.' -f 3- | rev)" = "$(echo $lineDB | rev | cut -d '/' -f 1 | rev)" ];then
      cd $backupDir
      bunzip2 -k $1
      tar xf $(echo $1 | rev | cut -d '.' -f 2- | rev) -C $(echo $lineDB | rev | cut -d '/' -f 2- | rev)
      rm -rf $(echo $1 | rev | cut -d '.' -f 2- | rev)
    fi
  done < "${dbFileLocation}database.db"
  cd ..
elif [ $2 = "o" ];then
  while read lineDB
  do
    if [ "$(echo $1 | rev | cut -d '.' -f 3- | rev)" = "$(echo $lineDB | rev | cut -d '/' -f 1 | rev)" ];then
      cd $backupDir
      bunzip2 -k $1
      tar xf $(echo $1 | rev | cut -d '.' -f 2- | rev) -C $3
      rm -rf $(echo $1 | rev | cut -d '.' -f 2- | rev)
    fi
  done < "${dbFileLocation}database.db"
  cd ..
fi
