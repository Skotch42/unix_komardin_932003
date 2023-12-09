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

    flock -u 9
    exec 9>&-

    echo "$(hostname) - $(date +%s)" > "/temp/$new_file"

    sleep 1

    rm "/temp/$new_file"

done
