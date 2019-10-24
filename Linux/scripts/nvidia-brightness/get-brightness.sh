#!/bin/sh

VAL=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')

PERC=$( echo "scale=0; ($VAL * 100)/1" | bc )

echo "$PERC%"
