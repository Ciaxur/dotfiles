#!/usr/bin/env bash

# Get Path of Current Script
DIR=`dirname $0`

# imports
source "$DIR/alacritty_utils.sh"
source "$DIR/gtk_utils.sh"

# Background Paths
BKG_OUT=~/Pictures/Background             # Path to Link Output for Background
BKG_LIGHT=~/Pictures/Background-Light     # Actual Path to Light-Themed Backgrounds
BKG_DARK=~/Pictures/Background-Dark       # Actual Path to Dark-Themed Backgrounds

# Make sure config is present.
CONFIG_FILEPATH="$DIR/config.json"
[ -f "$CONFIG_FILEPATH" ] || echo "{}" > "$CONFIG_FILEPATH"
CONFIG_VALUE="$(cat $CONFIG_FILEPATH)"

function update_config() {
  KEY="$1"
  VALUE="$2"
  CONFIG_VALUE=`jq ".$KEY=\"$VALUE\"" <(echo "$CONFIG_VALUE")`
}

function flush_config() {
  echo $CONFIG_VALUE > $CONFIG_FILEPATH
}

function print_help() {
  echo "Usage: $(basename $0) [options] [theme]"
  echo "  themes:         [dark, light, grey, tokyo-dark, challenger-deep]"
  echo "Options:"
  echo "  -l              Prints the currently applied configuration"
  echo "  -h  --help      Prints the help menu"
  exit 0
}

if [ "$1" = "" ] || [ "$1" == "--help" ]; then  # Empty Input or help argument
  print_help

elif [ "$1" = "-l" ]; then
  echo $CONFIG_VALUE | jq .

elif [ "$1" = "challenger-deep" ]; then
  echo "Activating Challenger Deep Mode"
  update_config "theme" "$1"

  # Set theme through GTK settings.
  set_gtk_theme "dark"
  update_config "gtk_theme" "dark"

  # Alacritty Config
  apply_alacritty_config "$1"

  # Copy Termite Theme
  cp $DIR/termite-configs/dark.config ~/.config/termite/config
  update_config "termite" "dark"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "tokyo-dark" ]; then            # Tokyo Dark Mode (Alacritty Only)
  echo "Activating Tokyo Dark Mode"
  update_config "theme" "$1"

  # Set theme through GTK settings.
  set_gtk_theme "dark"
  update_config "gtk_theme" "dark"

  # Alacritty Config
  apply_alacritty_config "$1"

  # Copy Termite Theme
  cp $DIR/termite-configs/dark.config ~/.config/termite/config
  update_config "termite" "dark"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "dark" ]; then            # Dark Mode
  echo "Activating Dark Mode"
  update_config "theme" "$1"

  # Set theme through GTK settings.
  set_gtk_theme "dark"
  update_config "gtk_theme" "dark"

  # Copy Termite Theme
  cp $DIR/termite-configs/dark.config ~/.config/termite/config
  update_config "termite" "dark"

  # Copy Alacritty Config
  apply_alacritty_config "$1"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "light" ]; then           # Light Mode
  echo "Activating Light Mode"
  update_config "theme" "$1"

  # Set theme through GTK settings.
  set_gtk_theme "light"
  update_config "gtk_theme" "light"

  # Copy Termite Theme
  cp $DIR/termite-configs/light.config ~/.config/termite/config
  update_config "termite" "light"

  # Copy Alacritty Config
  apply_alacritty_config "$1"

  # Add Symbolic Link for Light Theme
  rm $BKG_OUT
  ln -s $BKG_LIGHT $BKG_OUT

elif [ "$1" = "grey" ]; then            # Grey Mode
  echo "Activating Grey Mode"
  update_config "theme" "$1"

  # Set theme through GTK settings.
  set_gtk_theme "grey"
  update_config "gtk_theme" "grey"

  # Copy Termite Theme
  cp $DIR/termite-configs/grey.config ~/.config/termite/config
  update_config "termite" "grey"

  # Copy Alacritty Config
  apply_alacritty_config "$1"

else
  echo "Error: Unknown option '$1'"
  print_help
fi


# Update config file.
flush_config
