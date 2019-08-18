#!/bin/sh


# Enables/Disables Nightmode
# Parameters are on/off
nightmode() {
    if [ "$1" = "-h" ]; then
        echo "Parameters: [on/off] to trigger nightmode"
    
    elif [ "$1" = "off" ]; then
        redshift -x
    
    else
        redshift -x
        redshift -O 3000
    fi

}
