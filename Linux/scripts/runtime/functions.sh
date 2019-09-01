#!/bin/sh


# Enables/Disables Nightmode
# Parameters are on/off
nightmode() {

    if [ "$1" = "-h" ]; then
        echo "Parameters: [on/off] to trigger nightmode"
    
    elif [ "$1" = "off" ]; then
        redshift -x        &>/dev/null
        echo "Turning off Nightmode"

    # Actual Value to set Redshift (Checks if Integer)
    elif [ $1 -eq $1 2>/dev/null ] && [ ! -z "$1" ]; then
        redshift -x        &>/dev/null
        redshift -O $1     &>/dev/null

        echo "Setting Nightmode to $1"
    else
        redshift -x        &>/dev/null
        redshift -O 3000   &>/dev/null
        
        echo "Setting Nightmode to '3000'"
    fi

}

