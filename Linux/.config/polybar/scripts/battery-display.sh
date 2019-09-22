#!/bin/sh

# Battery Status Symbols (From FontAwesome)
CHARGE=''
LOW=''
MED=''
HIGH=''


#######################
# Obtain Battery Data #
#######################

# Two+ Liner
if [ `acpi | wc -l` -gt 1 ]; then
    bat=`acpi -b | awk 'END{print}' | awk '{print $4}' | grep -o '[0-9]\+'`
    chargeState="$(acpi -b | awk 'END{print}' | awk '{print $3}' | sed 's/,//g')"

# One Liner
else
    bat=`acpi -b | awk '{print $4}' | grep -o '[0-9]\+'`
    chargeState="$(acpi -b | awk '{print $3}' | sed 's/,//g')"
fi


# Change Colors based on States
# BAT = Grey ; $bat = white
if [ $bat -eq 100 ]; then
   echo "%{F#00DD00}$HIGH %{F#FFF}$bat%"

# BAT on 50%
elif [ $bat -le 50 ]; then
   echo "%{F#AAA}$MED %{F#FFF}$bat%"


# BAT = red ; $bat = white
elif [ $bat -lt 11 ] && [ $chargeState = "Discharging" ]; then
    echo " %{F#FF0000}$LOW %{F#FF4400}↓%{F#FFF}$bat%"

# BAT = orange ; $bat = white
elif [ $bat -lt 21 ] && [ $chargeState = "Discharging" ]; then
    echo "%{F#D35400}$MED %{F#FFB300}↓%{F#FFF}$bat%"

# BAT = green ; Discharging
elif [ $chargeState = "Discharging" ]; then
    echo "%{F#AAA}$HIGH %{F#37FF00}↓%{F#FFF}$bat%"


# BAT = green ; $bat = white
else
    echo "%{F#EEE}$CHARGE %{F#37FF00}↑%{F#FFF}$bat%" 
fi


