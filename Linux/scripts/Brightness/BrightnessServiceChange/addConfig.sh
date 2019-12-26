#!/bin/sh

config_file=/tmp/tmp123.brightness.conf
val=$1

if [ "$val" == "" ]; then
    val=0
fi

printf "[Brightness]\nval=$val\n" > $config_file
