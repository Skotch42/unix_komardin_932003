#!/bin/bash

while true
do
    (
    flock -x 3

    counter=1
        
    while [ -e "/my_volume/$(printf "%03d" $counter).txt" ]
    do
        ((counter++))
    done

    echo "$(hostname) $counter" > "/my_volume/$(printf "%03d" $counter).txt"

    sleep 1

    rm "/my_volume/$(printf "%03d" $counter).txt"

    ) 3>/var/lock/mylockfile

done
