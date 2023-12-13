#!/bin/bash

while true
do
    (
    flock -x 200

    counter=1
    while [ -e "/my_volume/$(printf "%03d" $counter).txt" ]
    do
        ((counter++))
    done

    container_id=$(cat /proc/self/cgroup | grep "docker" | sed 's/^.*\///' | head -n 1)
    echo "$container_id $counter" > "/my_volume/$(printf "%03d" $counter).txt"

    sleep 1

    rm "/my_volume/$(printf "%03d" $counter).txt"

    ) 200>/var/lock/container_lock

done
