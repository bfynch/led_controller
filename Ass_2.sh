#!/bin/bash

#method to print out the main menu. 
#iterates through the leds directory and displays all items in it
print_menu(){
i=0    
echo "LED Settings"
echo "----------------------"
leds=( `ls /sys/class/leds` )
for item in ${leds[@]}
do 
    let "i++"
    echo "$i $item"          
done
echo "Enter a number between 1 and $i"
menu_input
}

#reads the input from the user
#iterates through leds directory and creates case statement for each item
menu_input(){
echo "Make a selection: "
read INPUT
i=0 
leds=( `ls /sys/class/leds` )
for item in ${leds[@]}
    do
    let "i++"
    case $INPUT in 
        $i)
        led_action
        ;;
        
        *)
        clear
        echo "Invalid choice. Try again."
        print_menu
        ;;
        esac
done
}

#prints menu for the LED actions and reads user input
#creates case statement for each menu item
led_action(){
echo "Options for $item"
echo "-------------------"
echo "1) Turn on"
echo "2) Turn off"
echo "3) System event"
echo "4) Quit to main menu"
echo "Please enter a number between 1-4"
read choice
case $choice in
    1)
    sudo sh -c "echo 1 >/sys/class/leds/$item/brightness"
    print_menu
    ;;

    2)
    sudo sh -c "echo 0 >/sys/class/leds/$item/brightness"
    print_menu
    ;;

    3)
    system_event
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
    echo "$i) $sysevent"          
done
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
        sudo sh -c "echo $ae >/sys/class/leds/$item/trigger"
        print_menu
        break
        ;;
        
        #*)
        #echo "Try again"
        #break
        #;;
        esac
done
}

print_menu
