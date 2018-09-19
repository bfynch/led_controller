#!/bin/bash

#method to print out the main menu. 
#iterates through the leds directory and displays all items in it
print_menu(){
x=0    
echo "LED Settings"
echo "----------------------"
for item in `ls /sys/class/leds`
do 
    let "x++"
    echo "$x $item"          
done
echo "Enter a number between 1 and $x"
menu_input
}

#reads the input from the user
#iterates through leds directory and creates case statement for each item
menu_input(){
echo "Make a selection: "
read INPUT

i=0 

for item in `ls /sys/class/leds`
    do
    let "i++"
    case $INPUT in 
        $i)
        led_action
        break
        ;;
        
        #*)
        #echo "Try again"
        #break
        #;;
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
p=0
for se in `cat /sys/class/leds/$item/trigger`
do 
    let "p++"
    echo "$p) $se"          
done
echo "Enter a number between 1 and $p"
read event_input
action_event
}

#iterates through trigger directory and creates case statement for each item
#executes command based on user input 
action_event(){
l=0
for ae in `cat /sys/class/leds/$item/trigger`
    do
    let "l++"
    case $event_input in 
        $l)
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
