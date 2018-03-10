#!/bin/bash

# for each chrome process with pid chromePid
for chromePid in $(pgrep chrome); do

    # save major page fault count
    majorPageFaultCount=$(ps --no-headers -o maj_flt "$chromePid")

    # print info to screen
    printf "Chrome %s har forårsaket %s major page faults" "$chromePid" "$majorPageFaultCount"

    # if more than 1000, print msg
    if [[ $majorPageFaultCount -gt 1000 ]]; then
        printf " (mer enn 1000!)"
    fi

    printf "\n";

done
