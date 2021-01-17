#!/bin/sh

# Get Path of Current Script
DIR=`dirname $0`

# Background Paths
BKG_OUT=~/Pictures/Background             # Path to Link Output for Background
BKG_LIGHT=~/Pictures/Background-Light     # Actual Path to Light-Themed Backgrounds
BKG_DARK=~/Pictures/Background-Dark       #  Actual Path to Dark-Themed Backgrounds


if [ "$1" = "" ]; then                  # Empty Input
    echo "Enter [dark, light, grey] as an option for command [OPTIONS]"

elif [ "$1" = "dark" ]; then            # Dark Mode
    echo "Activating Dark Mode"

    # Copy GTK Theme
    cp $DIR/gtk-configs/settings-dark.ini ~/.config/gtk-3.0/settings.ini

    # Copy Termite Theme
    cp $DIR/termite-configs/dark.config ~/.config/termite/config

    # Copy vimrc Config
    cp $DIR/vimrc-configs/config-dark ~/.vimrc

    # Copy Alacritty Config
    cp $DIR/alacritty-configs/alacritty-dark.yml ~/.config/alacritty/alacritty.yml

    # Add Symbolic Link for Dark Theme
    rm $BKG_OUT
    ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "light" ]; then           # Light Mode
    echo "Activating Light Mode"

    # Copy GTK Theme
    cp $DIR/gtk-configs/settings-light.ini ~/.config/gtk-3.0/settings.ini

    # Copy Termite Theme
    cp $DIR/termite-configs/light.config ~/.config/termite/config

    # Copy vimrc Config
    cp $DIR/vimrc-configs/config-light ~/.vimrc

    # Copy Alacritty Config
    cp $DIR/alacritty-configs/alacritty-light.yml ~/.config/alacritty/alacritty.yml

    # Add Symbolic Link for Light Theme
    rm $BKG_OUT
    ln -s $BKG_LIGHT $BKG_OUT

elif [ "$1" = "grey" ]; then            # Grey Mode
    echo "Activating Grey Mode"

    # Copy GTK Theme
    cp $DIR/gtk-configs/settings-grey.ini ~/.config/gtk-3.0/settings.ini

    # Copy Termite Theme
    cp $DIR/termite-configs/grey.config ~/.config/termite/config

    # Copy Alacritty Config
    cp $DIR/alacritty-configs/alacritty-grey.yml ~/.config/alacritty/alacritty.yml

fi
