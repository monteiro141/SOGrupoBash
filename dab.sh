#!/bin/bash
# ----------------------------------- #
# DAB - Operating Systems work
# School Year: 2020/2021
# @author Bruno Monteiro,     a43994
# @author Alexandre Monteiro, a44149
# @author Duarte Arribas,     a44585
# @version 1.1
# ----------------------------------- #

#show dialog main box
dialog --title "(DAB)ackup" --clear --msgbox "Welcome to DuarteAlexBruno (DAB)ackup. The usage of the software can be read in the manual.\n\nPress OK to continue to the program. " 10 70
#OK pressed
if [ $? -eq 0 ];then 
  . ./src/menu/menumain.sh
fi
