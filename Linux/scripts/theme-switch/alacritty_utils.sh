#!/usr/bin/env bash

# Get Path of Current Script
DIR=`dirname $0`
ALACRITTY_CONFIG_FILEPATH="$HOME/.config/alacritty/alacritty.toml"

function apply_alacritty_config() {
  # Expecting theme name.
  THEME_NAME="$1"

  # Grab base config.
  ALACRITTY_CONFIG=`cat $DIR/alacritty-configs/base.toml`
  THEME_PATH="$DIR/alacritty-configs/alacritty-$THEME_NAME.toml"

  # Inject path to alacritty theme.
  echo -e "import = [ \"$THEME_PATH\" ] \n\n$ALACRITTY_CONFIG" > "$ALACRITTY_CONFIG_FILEPATH"
}

