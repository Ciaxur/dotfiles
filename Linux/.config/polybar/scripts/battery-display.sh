#!/bin/sh

# Obtain Battery Data
bat=`acpi -b | awk '{print $4}' | grep -o '[0-9]\+'`
chargeState="$(acpi -b | awk '{print $3}' | sed 's/,//g')"


# Change Colors based on States
# BAT = red ; $bat = white
if [ $bat -lt 11 ] && [ $chargeState = "Discharging" ]; then
    echo " 🔋%{F#FF4400}BAT %{F#FFF}$bat% "

# BAT = orange ; $bat = white
elif [ $bat -lt 21 ] && [ $chargeState = "Discharging" ]; then
    echo " 🔋%{F#FFB300}BAT %{F#FFF}$bat% "

# BAT = green ; $bat = white
else
    echo " 🔋%{F#37FF00}BAT %{F#FFF}$bat% "
fi


#echo " 🔋%{F#999}BAT %{F#FFF}$bat% "