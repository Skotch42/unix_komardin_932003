#!/bin/bash

while true
do
    exec 3>/my_volume/mylockfile
    flock -x 3

    counter=1
        
    while [ -e "/my_volume/$(printf "%03d" $counter).txt" ]
    do
        ((counter++))
    done
    
    exec 3<&-

    echo "$(hostname) $counter" > "/my_volume/$(printf "%03d" $counter).txt"

    sleep 1

    rm "/my_volume/$(printf "%03d" $counter).txt"

done
