#!/bin/bash

while true
do
    exec 3>/var/lock/mylockfile
    flock 3

    counter=1
        
    while [ -e "/my_volume/$(printf "%03d" $counter).txt" ]
    do
        ((counter++))
    done
    
    flock -u 3
    exec 3>&-

    echo "$(hostname) $counter" > "/my_volume/$(printf "%03d" $counter).txt"

    sleep 1

    rm "/my_volume/$(printf "%03d" $counter).txt"

done
