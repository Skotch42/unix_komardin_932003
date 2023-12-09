#!/bin/bash

generator()
{
    for i in {001..999}; do
        if [ ! -e "/temp/$i" ]; then
            echo "$i"
            break
        fi
    done
}

while true; do

    exec 9>/var/lock/mylockfile
    flock -n 9 || continue

    new_file=$(generator)

    current_count=$(cat /temp/temp_counter)

    echo $((current_count + 1)) > /temp/temp_counter

    flock -u 9
    exec 9>&-

    echo "$(hostname) - $(date +%T) - $current_count" > "/temp/$new_file"

    sleep 1

    rm "/temp/$new_file"

done
