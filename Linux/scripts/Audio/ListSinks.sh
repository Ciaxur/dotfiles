#!/bin/sh

# GET NUMBER OF SINKS (Output Audio Devices)
SINK_Index=$(pacmd list-sinks | grep 'index')      # List of Sink Indicies
ACTIVE_Index=$(printf "$SINK_Index" | grep "* index" | awk '{print $3}')


# LIST DATA
printf "== Detailed Info == \n"
pacmd list-sinks
printf "\n\n== Mian Sink List == \n$SINK_Index \n\n"
echo "Active Index: $ACTIVE_Index"
