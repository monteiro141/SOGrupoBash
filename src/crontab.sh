repeat=true
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15
while $repeat
do
    dialog --title "Menu" --menu "Regularidade semanal:" 0 0 0\
    "*" "Todos os dias"\
    1 "Todos os domingos"\
    2 "Todas as segundas feiras"\
    3 "Todas as terças feiras"\
    4 "Todas as quartas feiras"\
    5 "Todas as quintas feiras"\
    6 "Todas as sextas feiras" 2> $tempfile
    opt=$?
    week=$(cat $tempfile)
    case $opt in 
        0) ;;
        1) break;;
    esac
    dialog  --title 'Seleção mês' --inputbox 'Insira em que mês pretende que faça o backup (1 a 12); (* Todos os meses)' 0 0 2> opcoes.txt
    monthChoice=$(cat opcoes.txt)
    echo "" > opcoes.txt

    if [[ $monthChoice == "*" ]] || ([[ $monthChoice -ge 1 ]] && [[ $monthChoice -le 12 ]])
    then
        dialog  --title 'Seleção do dia do mês' --inputbox 'Dia do mês: (1 a 31); (* Todos os meses)' 0 0 2> opcoes.txt
        dayOftheMonthChoice=$(cat opcoes.txt)
        echo "" > opcoes.txt

        if [[ $dayOftheMonthChoice == "*" ]] || ([[ $dayOftheMonthChoice -ge 1 ]] && [[ $dayOftheMonthChoice -le 31 ]])
        then
            dialog  --title 'Seleção da hora' --inputbox 'Hora: (0 a 23); (* Toda a hora)' 0 0 2> opcoes.txt
            hourChoice=$(cat opcoes.txt)
            echo "" > opcoes.txt

            if [[ $hourChoice == "*" ]] || ([[ $hourChoice -ge 0 ]] && [[ $hourChoice -le 23 ]])
            then
                dialog  --title 'Seleção do minuto' --inputbox 'Minuto: (0 a 59); (* A cada minuto)' 0 0 2> opcoes.txt
                minuteChoice=$(cat opcoes.txt)

                if [[ $minuteChoice == "*" ]] || ([[ $minuteChoice -ge 0 ]] && [[ $minuteChoice -le 59 ]])
                then
                    (crontab -l >/dev/null; echo "$minuteChoice $hourChoice $dayOftheMonthChoice $monthChoice $week $(realpath backupCron.sh) $(pwd)") | crontab -
                    rm opcoes.txt
                    cat config/backup.cfg | grep -v ^"backupPeriod=" > config/fileoutput.txt
                    echo "backupPeriod=$minuteChoice $hourChoice $dayOftheMonthChoice $monthChoice $week" >> config/fileoutput.txt
                    mv config/fileoutput.txt config/backup.cfg
                    break
                fi
            fi
        fi
    fi
    rm opcoes.txt
done