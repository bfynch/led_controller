#!/bin/bash

echo "Enter a system process ID: "
read process

echo "What would you like to monitor?"
echo "1) CPU Usage"
echo "2) Memory Usage"
read choice

memusage=`ps -aux | grep $process | awk {'print $4'}`
cpuusage=`ps -aux | grep $process | awk {'print $3'}`

mem1=$memusage | awk {'print $1'}
cpu1=$cpuusage | awk {'print $1'}

case $choice in
    1)
    while true
    do
        cpuusage=`ps -aux | grep $process | awk {'print $3'}`
        cpu1=`echo $cpuusage | awk {'print $1'}`
        echo "Cpu is using $cpu1%"
        cpuon=`echo $cpu1/100 | bc -l`
        echo $cpuon
        cpuoff=`echo 1-$cpuon | bc -l`
        sudo sh -c "echo 1 >/sys/class/leds/led0/brightness"
        sleep $cpuon
        sudo sh -c "echo 0 >/sys/class/leds/led0/brightness"
        sleep $cpuoff
        echo "Restart"
        echo $cpuoff
    done
    ;;

    2)
    while true
    do
        memusage=`ps -aux | grep $process | awk {'print $4'}`
        mem1=`echo $memusage | awk {'print $1'}`
        echo "Memory is using $mem1%"
        memon=`echo $mem1/100 | bc -l`
        echo $memon
        memoff=`echo 1-$memon | bc -l`
        sudo sh -c "echo 1 >/sys/class/leds/led0/brightness"
        sleep $memon
        sudo sh -c "echo 0 >/sys/class/leds/led0/brightness"
        sleep $memoff
        echo "Restart"
        echo $memoff
    done
    ;;

    *)
    echo "Invalid choice"
    ;;
esac
