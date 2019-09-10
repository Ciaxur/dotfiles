#!/bin/sh

# Obtain Core Temperatures
PKG_TEMP=`sensors | grep -i package | awk '{print $4}' | grep -o '[0-9]\+' | awk 'NR==1{print $0}'`
CORE0_TEMP=`sensors | grep -i 'core 0' | awk '{print $3}' | grep -o '[0-9]\+' | awk 'NR==1{print $0}'`
CORE1_TEMP=`sensors | grep -i 'core 1' | awk '{print $3}' | grep -o '[0-9]\+' | awk 'NR==1{print $0}'`

# Obtain Core %
CPU_PERC=`top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{printf "%d%%", 100 - $1}'`

# Output Temperatures
#echo " %{F#FFF}CPU %{F#999}$PKG_TEMP°C $CORE0_TEMP°C $CORE1_TEMP°C "
echo "%{F#999}CPU %{F#FFF}$CPU_PERC %{F#999}[$PKG_TEMP $CORE0_TEMP $CORE1_TEMP]°C"

