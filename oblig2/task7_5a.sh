#!/bin/bash

# Print the menu and read user choice into $MESSAGE
function doMenu {

    printf '\n';

    # (not indented cause bash is stupid :D)
cat << EOF
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switch'er fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode
    og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
EOF

    # read message
    printf '\nVelg en funksjon: '
    read MESSAGE
    printf '\n';
}

doMenu

while [[ "$MESSAGE" != '9' ]]; do

    printf ">> ";

    case $MESSAGE in
    1)
        echo "Du er $(whoami) og navnet til dette scriptet er $(basename $0)"
        ;;
    2)
        echo "Tid sisten siste boot: $(uptime --pretty)"
        ;;
    3)
        echo "Antall tråder i systemet ditt er: $(ps axms --no-headers | wc -l)"
        ;;
    4)

        X=$(grep ctxt /proc/*/status | awk '{s+=$2} END {print s}')
        sleep 1
        Y=$(grep ctxt /proc/*/status | awk '{s+=$2} END {print s}')

        echo "Context switches i det siste sekundet$(($Y-$X))"
        ;;
    5)

        USERMODE=$(vmstat 1 2 | tail -1 | awk '{print $13}')
        KERNELMODE=$(vmstat 1 2 | tail -1 | awk '{print $14}')

        echo "Brukte $USERMODE% tid i usermode og $KERNELMODE% tid i kernel mode det siste sekundet"
        
        ;;
    6)
        X=$(cat /proc/interrupts | awk '{s+=$2+$3+$4+$5} END {print s}')
        sleep 1
        Y=$(cat /proc/interrupts | awk '{s+=$2+$3+$4+$5} END {print s}')

        echo "Interrupts i siste sekund: $(($Y-$X))"
        ;;
    *)
        echo "$MESSAGE???"
        ;;
    esac

    doMenu

done
