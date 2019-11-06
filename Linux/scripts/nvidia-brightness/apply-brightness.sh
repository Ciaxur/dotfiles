#!/bin/sh

# Make sure given Value
if [ "$1" = "" ]; then
    echo "Please enter a value to inc/dec from brightness!"
    exit 1
fi


BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`
NEW_BR=$( echo "scale=3; $BRIGHTNESS + $1" | bc )


echo "From $BRIGHTNESS to $NEW_BR"

# Increased Value over 1.0!
if (( $(echo "$NEW_BR > 1.0" | bc -l) )); then
    echo "TOO HIGH!"


# Decreased Value under 1.0!
elif (( $(echo "$NEW_BR < 0.0" | bc -l) )); then
    echo "TOO LOW!"


# Change Value
else 
    xrandr --output eDP-1-1 --brightness $NEW_BR
fi



exit 1
