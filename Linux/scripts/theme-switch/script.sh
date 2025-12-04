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

function apply_common() {
  THEME_NAME="$1"
  THEME_KIND="$2"

  update_config "theme" "$THEME_NAME"

  # Set theme through GTK settings.
  set_gtk_theme "$THEME_KIND"
  update_config "gtk_theme" "$THEME_KIND"

  # Copy Termite Theme
  cp "$DIR/termite-configs/${THEME_KIND}.config" ~/.config/termite/config
  update_config "termite" "$THEME_KIND"

  # Copy Alacritty Config
  apply_alacritty_config "$THEME_NAME"
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
  apply_common "$1" "dark"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "tokyo-dark" ]; then            # Tokyo Dark Mode (Alacritty Only)
  echo "Activating Tokyo Dark Mode"
  apply_common "$1" "dark"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "dark" ]; then            # Dark Mode
  echo "Activating Dark Mode"
  apply_common "$1" "dark"

  # Add Symbolic Link for Dark Theme
  rm $BKG_OUT
  ln -s $BKG_DARK $BKG_OUT

elif [ "$1" = "light" ]; then           # Light Mode
  echo "Activating Light Mode"
  apply_common "$1" "light"

  # Add Symbolic Link for Light Theme
  rm $BKG_OUT
  ln -s $BKG_LIGHT $BKG_OUT

elif [ "$1" = "grey" ]; then            # Grey Mode
  echo "Activating Grey Mode"
  apply_common "$1" "grey"
  # Copy Alacritty Config
  apply_alacritty_config "$1"

else
  echo "Error: Unknown option '$1'"
  print_help
fi


# Update config file.
flush_config
