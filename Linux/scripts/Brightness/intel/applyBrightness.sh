#!/bin/sh

# MAKE SURE PARAMTER PASSED
if [ "$1" = "" ]; then
    echo "NO PARAMETER!!!"
    echo "Please enter [+/-]VAL"
    exit 1
fi

NEW_VAL=$(echo "scale=1;( ($(brightnessctl g) / $(brightnessctl m)) * 100 ) $1" | bc)
brightnessctl s $NEW_VAL%
echo $NEW_VAL
