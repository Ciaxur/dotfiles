#!/bin/sh

# GET ACTIVE SINK
index=$(pacmd list-sinks | grep '* index' | awk '{print $3}')
pactl set-sink-mute $index toggle
