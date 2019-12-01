#!/bin/sh

# CHECK PARAMETERS
if [ "$1" = "" ] || [ "$1" = "-h" ]; then
    echo "Lists Given Sink Index's Information"
    exit 1
fi

# LIST GIVEN INDEX SINK INFO
pacmd list-sinks | sed -n -e "/index: $1/,/index:/ p"
