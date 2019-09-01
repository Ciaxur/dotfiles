#!/bin/sh

# Obtain Percentage
bat=`acpi -b | awk '{print $4}' | grep -o '[0-9]\+'`

echo " 🔋%{F#999}BAT %{F#FFF}$bat% "
