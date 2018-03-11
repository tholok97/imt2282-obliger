#!/bin/bash

for pid; do

    # store relevant values in variables
    VMSIZE=$(grep VmSize /proc/"$pid"/status | awk '{print $2}')
    VMDATA=$(grep VmData /proc/"$pid"/status | awk '{print $2}')
    VMSTK=$(grep VmStk /proc/"$pid"/status | awk '{print $2}')
    VMEXE=$(grep VmExe /proc/"$pid"/status | awk '{print $2}')
    VMLIB=$(grep VmLib /proc/"$pid"/status | awk '{print $2}')
    VMRSS=$(grep VmRSS /proc/"$pid"/status | awk '{print $2}')
    VMPTE=$(grep VmPTE /proc/"$pid"/status | awk '{print $2}')

    # build filename
    FILENAME="$pid"-$(date +%F_%R).meminfo

    # print info to file
    echo "******** Minne info om prosess med PID 17579 ********
Total bruk av virtuelt minne (VmSize): $VMSIZE KB
Mengde privat virtuelt minne (VmData+VmStk+VmExe): $(($((VMDATA + VMSTK)) + VMEXE)) KB
Mengde shared virtuelt minne (VmLib): $VMLIB KB
Total bruk av fysisk minne (VmRSS): $VMRSS KB
Mengde fysisk minne som benyttes til page table (VmPTE): $VMPTE KB" > "$FILENAME"

done
