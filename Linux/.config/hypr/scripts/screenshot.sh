#!/usr/bin/env bash

function help() {
  echo "Usage: script [options...]"
  echo
  echo "  -h            Show help message and quit."
  echo "  -c            Toggle saving screenshot to clipboard."
  echo "  -w            Takes a screenshot of a window"
}

# Default vars.
SAVE_TO_CLIP=0
SLURP_ARGS=""

# Parse command-line options
while [[ $# -gt 0 ]]; do
  case $1 in
    -c)
      SAVE_TO_CLIP=1
      shift
      ;;
    -w)
      SLURP_ARGS="$SLURP_ARGS -o"
      shift
      ;;
    -h)
      help
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      help
      exit 1
      ;;
  esac
done

# Using grim + slurp to take a screenshot.
IMG_NAME="grim_screenshot_$(date +'%Y-%m-%d_%Hh%Mm%Ss').png"
DEFAULT_OUTPUT="$HOME/Pictures/$IMG_NAME"

# Take the screenshot and save to clipboard if '-c' was passed in, otherwise
# save to default directory.
if [[ "$SAVE_TO_CLIP" = "1" ]]; then
  grim -g "$(slurp ${SLURP_ARGS})" - | wl-copy
  notify-send "Screenshot" "Captured screenshot into clipboard"
else
  grim -g "$(slurp ${SLURP_ARGS})" - > "$DEFAULT_OUTPUT"
  notify-send "Screenshot" "Captured screenshot in \n$DEFAULT_OUTPUT"
fi

