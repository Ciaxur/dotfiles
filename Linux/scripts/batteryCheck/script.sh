#!/bin/sh

# Temporary Dump
tempFile="/tmp/bat-dump-temp.dump"


# Obtain Battery Percentage
bat="$(acpi -b | awk '{print $4}' | grep -o '[0-9]\+')"

# Obtain Status from Temp File (If Any)
# Status (0 = Not Notified | 1 = Notified <20% | 2 = Notified <10% | 3 = Notified <5% )
status=0
if [ -f "$tempFile" ];then
    status=`cat $tempFile`
fi


# Notify User of Battery Status!
# BATTERY CRITICAL : Battery under 20%!
if [ $bat -lt 21 ] && [ $status -eq 0 ]; then       # Notify User if not Notified Before
    notify-send "Battery at 20%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "1" > $tempFile                            # Notified!


# BATTERY CRITICAL : Battery under 10%!
elif [ $bat -lt 11 ] && [ $status -eq 1 ]; then
    notify-send "Battery at 10%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "2" > $tempFile

# BATTERY CRITICAL : Battery under 5%!
elif [ $bat -lt 6 ] && [ $status -eq 2 ]; then
    notify-send "Battery at 5%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
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
