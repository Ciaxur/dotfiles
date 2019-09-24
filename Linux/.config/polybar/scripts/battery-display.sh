#!/bin/sh

# Battery Status Symbols (From FontAwesome)
CHARGE=''
LOW=''
MED_LOW=''
MED=''
MED_FULL=''
FULL=''


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
   echo "%{F#00DD00}$FULL %{F#FFF}$bat%"


# BAT on 10% = red ; $bat = white
elif [ $bat -le 10 ] && [ $chargeState = "Discharging" ]; then
    echo " %{F#FF0000}$LOW %{F#FF4400}↓%{F#FFF}$bat%"

# BAT on 20% = orange ; $bat = white
elif [ $bat -le 20 ] && [ $chargeState = "Discharging" ]; then
    echo "%{F#D35400}$MED_LOW %{F#FFB300}↓%{F#FFF}$bat%"

# BAT on 35%
elif [ $bat -le 35 ] && [ $chargeState = "Discharging" ]; then
    echo "%{F#FF7F06}$MED_LOW %{F#FFB300}↓%{F#FFF}$bat%"

# BAT on 50%
elif [ $bat -le 50 ] && [ $chargeState = "Discharging" ]; then
    echo "%{F#F0FF06}$MED %{F#FFB300}↓%{F#FFF}$bat%"

# BAT on 50%
elif [ $bat -le 75 ] && [ $chargeState = "Discharging" ]; then
    echo "%{F#EEE}$MED_FULL %{F#FFB300}↓%{F#FFF}$bat%"


# BAT > 75% = green ; Discharging
elif [ $chargeState = "Discharging" ]; then
    echo "%{F#EEE}$FULL %{F#37FF00}↓%{F#FFF}$bat%"


# BAT = green ; $bat = white
else
    echo "%{F#EEE}$CHARGE %{F#37FF00}↑%{F#FFF}$bat%" 
fi


