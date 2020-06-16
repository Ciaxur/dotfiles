#!/bin/sh

# Get Random Image from Directory
imageDIR=~/Pictures/Background
picture=`ls $imageDIR | shuf -n 1`

# Set it!
gsettings set org.gnome.desktop.background picture-uri "$imageDIR/$picture"
