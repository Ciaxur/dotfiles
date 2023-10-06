#!/usr/bin/env bash
# Script for extending functionality to dispatch setting a given size
# to the active window.

# Expected args <WIDTH HEIGHT>.
# Params:
#   WIDTH - Width to set the active window to.
#   HEIGHT - Height to set the active window to.
WIDTH=$1
HEIGHT=$2

if [[ "$WIDTH" = "" || "$HEIGHT" = "" ]]; then
  echo "Missing argument. Expected <WIDTH> <HEIGHT> arguments to be passed in."
  exit 1
fi

# Get the active window's dimensions.
WINDOW_WIDTH=$(hyprctl activewindow | rg "size: (\d+),(\d+)" -r '$1')
WINDOW_HEIGHT=$(hyprctl activewindow | rg "size: (\d+),(\d+)" -r '$2')

DIFF_WINDOW_WIDTH=$(($WIDTH - $WINDOW_WIDTH))
DIFF_WINDOW_HEIGHT=$(($HEIGHT - $WINDOW_HEIGHT))

# Dispatch window resize based on the dimension difference.
hyprctl dispatch resizeactive $DIFF_WINDOW_WIDTH $DIFF_WINDOW_HEIGHT
