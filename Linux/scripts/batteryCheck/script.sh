#!/bin/sh

# Temporary Dump
tempFile="/tmp/bat-dump-temp.dump"


# Obtain Battery Percentage
bat="$(acpi -b | awk '{print $4}' | grep -o '[0-9]\+')"

# Obtain Status from Temp File (If Any)
# Status (0 = Not Notified | 1 = Notified)
status=0
if [ -f "$tempFile" ];then
    status=`cat $tempFile`
fi


# Notify User of Battery Status!
if [ $bat -lt 21 ] && [ $status -eq 0 ]; then       # Notify User if not Notified Before
    notify-send "Battery at 20%! 🔋" "Find a power source as soon as possible! 🔌" -u critical
    echo "1" > $tempFile                            # Notified!


# Reset Notification Status if Battery % Over Critical
elif [ $bat -gt 20 ]; then
    echo "0" > $tempFile

fi




# DEBUGGING
#echo "$(date)" >> /tmp/out
#echo "Battery = $bat%" >> /tmp/out
#echo "Status = $status\n" >> /tmp/out

# Exit Program Successfully :)
exit 0
