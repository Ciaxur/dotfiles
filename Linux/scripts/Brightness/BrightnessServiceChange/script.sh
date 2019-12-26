#!/bin/sh

# MAKE SURE FILE EXISTS
config_file=/tmp/tmp123.brightness.conf
if [ ! -f $config_file ]; then
    exit 1              # Doesn't Exist
fi



# BEGIN PARSING & CHANGE BRIGHTNESS
IFS="="
valid=0

while read -r name value; do
    value=${value//\"/}             # Clean up Value

    # Header Value
    if [ "$value" == "" ]; then      
        name=$(echo $name | sed 's/[][]//g')    # Clean up Brackets

        # Check for Brightness Header
        if [ "$name" == "Brightness" ]; then
            valid=1
        else
            valid=0
        fi

    # Actual Sub-Header Data
    elif [ "$name" == "val" ] && [ $valid == 1 ]; then
        # Change Brightness to value
        NEW_VAL=$(echo "scale=1;( ($(brightnessctl g) / $(brightnessctl m)) * 100 ) $value" | bc)
        brightnessctl s $NEW_VAL%
        #echo "Value is $value"


    fi
done < $config_file


# CLEAN UP
rm $config_file
exit 0
