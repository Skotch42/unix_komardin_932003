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

    exec 5>/var/lockfile
    flock -n 5 || continue

    new_file=$(generator)

    flock -u 5
    exec 5>&-

    echo "$(hostname) - $(date +%s)" > "/temp/$new_file"

    sleep 1

    rm "/temp/$new_file"

done
