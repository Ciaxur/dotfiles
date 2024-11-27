#!/usr/bin/env bash

# Get Path of Current Script
DIR=`dirname $0`
ALACRITTY_USER_CONFIG="$HOME/.config/alacritty/alacritty.toml"
ALACRITTY_THEME_DIR="$DIR/alacritty-configs"

# Applies the given alacritty theme to the base config.
function apply_alacritty_config() {
  # Expecting theme name.
  THEME_NAME="$1"

  # Grab base config.
  ALACRITTY_CONFIG=`cat $DIR/alacritty-configs/base.toml`
  THEME_PATH="$ALACRITTY_THEME_DIR/alacritty-$THEME_NAME.toml"

  # Inject path to alacritty theme.
  echo -e "general.import = [ \"$THEME_PATH\" ] \n\n$ALACRITTY_CONFIG" > "$ALACRITTY_USER_CONFIG"
}

# Given a filepath, iterates over all the themes one by one.
function try_themes_from_path() {
  THEME_FILEPATH="$1"

  # Grab base config.
  ALACRITTY_CONFIG=`cat $DIR/alacritty-configs/base.toml`

  # Iterate over all themes.
  echo "Press enter to iterate over the themes."
  THEMES=$(find "$THEME_FILEPATH" -type f)
  TOTAL_THEMES=$(echo "$THEMES" | wc -l)

  i=1
  for theme in $THEMES; do
    printf "[$i/$TOTAL_THEMES]Applying theme -> $theme"

    # Inject path to alacritty theme.
    echo -e "import = [ \"$theme\" ] \n\n$ALACRITTY_CONFIG" > "$ALACRITTY_USER_CONFIG"

    read
    i=$(( i + 1 ))
  done
}

