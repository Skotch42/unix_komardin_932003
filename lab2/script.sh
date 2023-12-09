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

    echo "$(hostname) - $(date +%s%3N)" > "/temp/$new_file"

    flock -u 9
    exec 9>&-

    sleep 1

    rm "/temp/$new_file"

done
