#!/bin/sh

# Get Path of Current Script
DIR=`dirname $0`

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

elif [ "$1" = "grey" ]; then            # Grey Mode
    echo "Activating Grey Mode"

    # Copy Alacritty Config
    cp $DIR/alacritty-configs/alacritty-grey.yml ~/.config/alacritty/alacritty.yml

fi
