#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Get Current Directory Full Path
CURR_DIR=`dirname $0`

rofi -show run \
  -font 'SF Compact 10' \
  -show-icons \
  -matching regex \
  -max-history-size 50 \
  -dpi 96 \
  -no-sort \
  -theme "$CURR_DIR/Paper.rasi"

