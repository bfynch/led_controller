#!/bin/bash

case $2 in
    1)
    while true
    do
        cpuusage=`ps -aux | grep $1 | awk {'print $3'}`
        cpu1=`echo $cpuusage | awk {'print $1'}`
        cpuon=`echo $cpu1/100 | bc -l`
        cpuoff=`echo 1-$cpuon | bc -l`
        sudo sh -c "echo 1 >/sys/class/leds/$3/brightness"
        sleep $cpuon
        sudo sh -c "echo 0 >/sys/class/leds/$3/brightness"
        sleep $cpuoff
    done
    ;;

    2)
    while true
    do
        memusage=`ps -aux | grep $1 | awk {'print $4'}`
        mem1=`echo $memusage | awk {'print $1'}`
        memon=`echo $mem1/100 | bc -l`
        memoff=`echo 1-$memon | bc -l`
        sudo sh -c "echo 1 >/sys/class/leds/$3/brightness"
        sleep $memon
        sudo sh -c "echo 0 >/sys/class/leds/$3/brightness"
        sleep $memoff
    done
    ;;

    *)
    echo "Invalid choice"
    ;;
esac
