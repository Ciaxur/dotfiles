#!/bin/sh

# GET PARAMETERS
if [ "$1" = "-h" ] || [ "$1" = "" ]; then
    echo "Adjusts Active Audio Output Sink's Volume"
    printf "\tParameter 1: [+/-] Volume\n\n"

    exit 0
fi

# GET ACTIVE SINK
index=$(pacmd list-sinks | grep '* index' | awk '{print $3}')

# APPLY VOLUME CHANGE
pactl -- set-sink-volume $index $1%

