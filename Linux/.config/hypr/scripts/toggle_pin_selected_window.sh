#!/usr/bin/env bash

# Grabs information about the selected application.
# NOTE: Routing output to stderr, to deconflict with stdout pipe
echo "Select an application on the screen to pin" >&2

function print_pinned_state() {
  STATE=$(hyprctl activewindow -j | jq -r .pinned)
  echo "Pinned state: ${STATE}"
}

# Button click events look like this:
# event6   POINTER_BUTTON          +2.827s       BTN_LEFT (272) pressed, seat count: 1
sudo libinput debug-events 2>/dev/null| while read -r line; do
  if [[ "$line" =~ "BTN_LEFT" ]] && [[ "$line" =~ "pressed" ]]; then
    MOUSE_POS="$(hyprctl cursorpos)"
    echo "Clicked on position: $MOUSE_POS" >&2
    hyprctl dispatch pin
    print_pinned_state
    break
  fi
done

