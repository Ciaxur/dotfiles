#!/bin/sh

# Temporary Dump
tempFile="/tmp/bat-dump-temp.dump"

# Configure Command to send Desktop Notification (user=omar | userid=1000)
alias SESSION='sudo -u omar DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus'


# Obtain Battery Percentage
# Two+ Liner
if [ `acpi | wc -l` -gt 1 ]; then
    bat=`acpi -b | awk 'END{print}' | awk '{print $4}' | grep -o '[0-9]\+'`
    chargeState="$(acpi -b | awk 'END{print}' | awk '{print $3}' | sed 's/,//g')"

# One Liner
else
    bat=`acpi -b | awk '{print $4}' | grep -o '[0-9]\+'`
    chargeState="$(acpi -b | awk '{print $3}' | sed 's/,//g')"
fi


# Obtain Status from Temp File (If Any)
# Status (0 = Not Notified | 1 = Notified <20% | 2 = Notified <10% | 3 = Notified <5% )
status=0
if [ -f "$tempFile" ];then
    status=`cat $tempFile`
fi

# Notify User of Battery Status!
# Notify User if not Notified Before if Discharging
# BATTERY CRITICAL : Battery under 20%!
if [ $bat -lt 21 ] && [ $status -eq 0 ] && [ "$chargeState" = "Discharging" ]; then
    echo "HI"
    SESSION notify-send -a "Battery Service" "Battery at 20%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "1" > $tempFile                            # Notified!


# BATTERY CRITICAL : Battery under 10%!
elif [ $bat -lt 11 ] && [ $status -eq 1 ] && [ "$chargeState" = "Discharging" ]; then
    SESSION notify-send -a "Battery Service" "Battery at 10%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "2" > $tempFile

# BATTERY CRITICAL : Battery under 5%!
elif [ $bat -lt 6 ] && [ $status -eq 2 ] && [ "$chargeState" = "Discharging" ]; then
    SESSION notify-send -a "Battery Service" "Battery at 5%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "3" > $tempFile





# RESET NOTIFICATION : Battery 5% Over Critical
elif [ $bat -gt 5 ] && [ $bat -lt 11 ]; then
    echo "2" > $tempFile

# RESET NOTIFICATION : Battery 10% Over Critical
elif [ $bat -gt 10 ] && [ $bat -lt 21 ]; then
    echo "1" > $tempFile


# RESET NOTIFICATION : Battery 20% Over Critical
elif [ $bat -gt 20 ]; then
    echo "0" > $tempFile

fi




# DEBUGGING
#echo "$(date)" >> /tmp/out
#echo "Battery = $bat%" >> /tmp/out
#echo "Status = $status\n" >> /tmp/out

# Exit Program Successfully :)
exit 0
