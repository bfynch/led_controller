CONTENTS OF THIS FILE
---------------------
   
 * Introduction
 * Requirements
 * Installation
 * Configuration
 * Troubleshooting
 * Maintainers


 INTRODUCTION
--------------------

This program allows user to configure and manipulate the LEDs on their pi, and the LEDs of other devices connected to the pi. This includes turning the LED on or off, associating the LED with a system event, and associating the LED with a process.  
This simple program is controlled entirely from the command line with the keyboard. 
 

 REQUIREMENTS
--------------------

This module requires the following modules:

* bc  (sudo apt-get install bc)


 INSTALLATION 
--------------------

After installing the required modules, all that is required is to extract sys_process.sh and led_config.sh to the same directory.


 CONFIGURATION 
--------------------

All of the configuration is done within the program. To configure the LEDs simply follow the menus. 


 TROUBLESHOOTING 
--------------------

* If the LED is assigned to a system process and it isn't showing accurate CPU/RAM usage:

    - Run the command 'ps -aux' in another terminal window to ensure you have entered the correct process id.

    - Assign the LED again with the same process id making sure to select the correct resource to track(CPU or Memory usage).


 MAINTAINERS 
--------------------

Current maintainers:

    * Benjamin Fynch - s3589828
