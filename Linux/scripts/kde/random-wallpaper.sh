#!/bin/sh

# Get Random Image from Directory
imageDIR=~/Pictures/Background
picture=`ls $imageDIR | shuf -n 1`
curPath=`dirname $0`        # Store Current Path

# Set it!
#gsettings set org.gnome.desktop.background picture-uri "$imageDIR/$picture"

dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        d.writeConfig("Image", "file://'$imageDIR/$picture'");
}'

# Save Image Path
echo "$imageDIR/$picture" > $curPath/selectedImage

