#!/usr/bin/env bash

# Grabs information about the selected application.
# NOTE: Routing output to stderr, to deconflict with stdout pipe
echo "Select an application on the screen" >&2

function get_window_info() {
  hyprctl activewindow -j | jq .
}

# Button click events look like this:
# event6   POINTER_BUTTON          +2.827s       BTN_LEFT (272) pressed, seat count: 1
libinput debug-events 2>/dev/null| while read -r line; do
  if [[ "$line" =~ "BTN_LEFT" ]] && [[ "$line" =~ "pressed" ]]; then
    MOUSE_POS="$(hyprctl cursorpos)"
    echo "Clicked on position: $MOUSE_POS" >&2
    get_window_info
    break
  fi
done

