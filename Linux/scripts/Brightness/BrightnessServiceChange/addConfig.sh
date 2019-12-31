#!/bin/sh


# VARIABLES
config_file=/tmp/tmp123.brightness.conf
val=$1

# MAKE SURE FILE DOESN'T EXIST
if [ -f $config_file ]; then
    exit 1

elif [ "$val" == "" ]; then
    val=0
fi

# ADD FILE
printf "[Brightness]\nval=$val\n" > $config_file
