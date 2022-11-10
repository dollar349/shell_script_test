#!/bin/bash
fifo_name="/tmp/guest.out"
while true
do
    if read line; then
        echo $line
    fi
done <"$fifo_name"
