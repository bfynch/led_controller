#!/bin/bash

#method to print out the main menu. 
#iterates through the leds directory and displays all items in it
print_menu(){
i=0    
echo "LED Settings"
echo "----------------------"
#leds=( `ls /sys/class/leds` )
for item in `ls /sys/class/leds`
do 
    let "i++"
    echo "$i) $item"          
done
    let "i++"
    echo "$i) Quit"
echo "Enter a number between 1 and $i"
menu_input
}

#reads the input from the user
#iterates through leds directory and creates case statement for each item
menu_input(){
echo "Make a selection: "
read INPUT
i=0 
#leds=( `ls /sys/class/leds` )
for item in `ls /sys/class/leds`
    do
    let "i++"
    case $INPUT in 
        $i)
        clear
        led_action
        ;;
        esac
    done
    let "i++"
    case $INPUT in
        $i)
        process=`ps x | grep led_config | awk {'print $1'}`
        kill $process
        ;;
        
        *)
        clear
        echo "Invalid choice. Please try again."
        print_menu
        ;;
    esac
}

#prints menu for the LED actions and reads user input
#creates case statement for each menu item
led_action(){
echo "Options for $item"
echo "-------------------"
echo "1) Turn on"
echo "2) Turn off"
echo "3) Associate with a System event"
echo "4) Associate with the Performance of a Process"
echo "5) Stop Association with the Performance of a Process"
echo "6) Quit to main menu"
echo "Please enter a number between 1-6"
read choice
case $choice in
    1)
    clear
    sudo sh -c "echo 1 >/sys/class/leds/$item/brightness"
    print_menu
    ;;

    2)
    clear
    sudo sh -c "echo 0 >/sys/class/leds/$item/brightness"
    print_menu
    ;;

    3)
    clear
    system_event
    ;;

    4)
    clear
    sys_process
    ;;
    
    5)
    kill_process
    clear
    led_action
    ;;
    
    6)
    clear
    print_menu
    ;;

    *)
    clear
    echo "Invalid choice. Please try again."
    led_action
    ;;
esac
}

#iterates through trigger directory and displays all items 
#reads user input
system_event(){
echo "Events available for $item"
echo "---------------------------"
i=0
for sysevent in `cat /sys/class/leds/$item/trigger`
do 
    let "i++"
    echo "$i) ${sysevent//[[,.!]}" | sed -e 's,],*,g'   
done
    let "i++"
    echo "$i) Quit"
echo "Enter a number between 1 and $i"
read event_input
action_event
}

#iterates through trigger directory and creates case statement for each item
#executes command based on user input 
action_event(){
i=0

for ae in `cat /sys/class/leds/$item/trigger`
    do
    let "i++"
    case $event_input in 
        $i)
        clear
        sudo sh -c "echo $ae >/sys/class/leds/$item/trigger"
        print_menu
        break
        ;;
        esac
    done
    let "i++"
    case $event_input in
        $i)
        clear
        print_menu
        ;;

        *)
        clear
        echo "Invalid choice. Please try again."
        system_event
        break
        ;;
        esac
}

#prompts user to enter a process id, and either memory or cpu
#sends the variables to the sys_process script and runs it in the background
#kills other sys_process because it causes conflict if more than 1 running in background
sys_process(){
    kill_process
    echo "Enter a system process ID: "
    read process
    clear

    echo "What would you like to monitor?"
    echo "1) CPU Usage"
    echo "2) Memory Usage"
    read choice

    ./sys_process.sh $process $choice $item &
    clear
    print_menu
}

#displays processes, grabs process called sys_process, and prints first column(process ID)
#saves the process ID as a variable and then kills that process
kill_process(){
    process=`ps x | grep sys_process | awk {'print $1'}`
    kill $process
    clear
}
trap '' 2
print_menu
