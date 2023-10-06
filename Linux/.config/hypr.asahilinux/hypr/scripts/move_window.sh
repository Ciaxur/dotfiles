#!/usr/bin/env bash
# Determines movement of active window based on it's tiled state.
#
# If the window is tiled, then dispatch movement between the current
# tiled configuration. Else, move floating window X,Y pixels.
FLOATING_DIRECTION_X="$1"; shift
FLOATING_DIRECTION_Y="$1"; shift
TILED_DIRECTION="$1"; shift

if [[ $FLOATING_DIRECTION_X == "" || $FLOATING_DIRECTION_Y == "" || $TILED_DIRECTION == "" ]]; then
  echo "Error: This script expects to be invoked: move_window.sh <X> <Y> <l|r|u|d>"
  exit 1
fi

# Determine the floating state of the currently active window and
# move window accordingly.
if [ "$(hyprctl activewindow -j | jq .floating)" == true ]; then
  echo "Moving floating window  $FLOATING_DIRECTION_X   $FLOATING_DIRECTION_Y"
  hyprctl dispatch moveactive  "$FLOATING_DIRECTION_X" "$FLOATING_DIRECTION_Y"
else
  # Grab the grouped state of the current window.
  ACTIVE_WINDOW_GROUPS_LEN=$(hyprctl activewindow -j | jq .grouped | jq 'length')

  # Move active window within the group.
  if [ "$ACTIVE_WINDOW_GROUPS_LEN" != 0 ]; then
    echo "Moving group window $TILED_DIRECTION"
    if [ "$TILED_DIRECTION" == "r" ]; then
      hyprctl dispatch movegroupwindow n
    else
      hyprctl dispatch movegroupwindow b
    fi
    exit 0
  fi

  # Move the tiled window.
  echo "Moving tiled window    $TILED_DIRECTION"
  hyprctl dispatch movewindow "$TILED_DIRECTION"
fi

