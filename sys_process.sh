#!/bin/bash

#reads the second variable sent to the case statement(memory or cpu)
#then searches all running processes for the first variable(process id)
#if cpu was selected it reads the 3rd column which represents cpu usage in %
#if memory was selected it reads the 4th column which represents memory usage in %
#it then takes the first result and divides by 100
#ie if cpu/ram is at 100% then the led will be on for 1 second(100/100=1)
#then the led will be off for the remaining time
#ie 70% cpu usage = 70/100=0.7 meaning the led will be on for 0.7 of a second and off for 0.3 of a second
#this is repeated until the process is killed
case $2 in
    1)
    while true
    do
        cpuusage=`ps -aux | grep $1 | awk {'print $3'}`
        for proc in cpuusage
            do
               echo "$proc"
            done 
        # cpu1=`echo $cpuusage | awk {'print $1'}`
        # cpuon=`echo $cpu1/100 | bc -l`
        # cpuoff=`echo 1-$cpuon | bc -l`
        # sudo sh -c "echo 1 >/sys/class/leds/$3/brightness"
        # sleep $cpuon
        # sudo sh -c "echo 0 >/sys/class/leds/$3/brightness"
        # sleep $cpuoff
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
