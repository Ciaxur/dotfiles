#!/bin/sh

# EMOJI
CPU_I=''

# GET & PRINT RESULT
CPU_PERC=`top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{printf "%d", 100 - $1}'`



echo "$CPU_I %{F#FF}$CPU_PERC%"
