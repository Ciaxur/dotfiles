#!/usr/bin/env bash

DIR_RELPATH="$(dirname $0)"

function help() {
  echo "Usage: script [options...]"
  echo
  echo "  -h            Show help message and quit."
  echo "  -c            Toggle saving screenshot to clipboard."
  echo "  -d            Takes a screenshot of the selected display"
  echo "  -w            Takes a screenshot of the selected application window"
}

# Default vars.
SAVE_TO_CLIP=0
SLURP_ARGS=""
CAPTURE_WINDOW=0

# Custom function which grabs window information
# under cursor, resulting in an output which matches
# slurp's output.
function slurp_window() {
  # Grab the application window to select.
  RESULT_JSON=`$DIR_RELPATH/get_app_info.sh`

  # Grab result and format in a way that matches slurp's output.
  WINDOW_AT_X="$(echo $RESULT_JSON | jq .at[0])"
  WINDOW_AT_Y="$(echo $RESULT_JSON | jq .at[1])"
  WINDOW_AT="${WINDOW_AT_X},${WINDOW_AT_Y}"

  WINDOW_SIZE_X="$(echo $RESULT_JSON | jq .size[0])"
  WINDOW_SIZE_Y="$(echo $RESULT_JSON | jq .size[1])"
  WINDOW_SIZE="${WINDOW_SIZE_X}x${WINDOW_SIZE_Y}"

  echo "$WINDOW_AT $WINDOW_SIZE"
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
  case $1 in
    -c)
      SAVE_TO_CLIP=1
      shift
      ;;
    -d)
      SLURP_ARGS="$SLURP_ARGS -o"
      shift
      ;;
    -w)
      CAPTURE_WINDOW=1
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

# Grab location to obtain screenshot of.
SLURP_RESULT=""

# Requires https://github.com/ciaxur/png_img_radius_strip
IMG_RADIUS=10

if [[ "$CAPTURE_WINDOW" = "1" ]]; then
  notify-send "Screenshot" "Select window to screenshot"
  SLURP_RESULT="$(slurp_window)"

  if [[ "$SAVE_TO_CLIP" = "1" ]]; then
    png_radius_strip -r $IMG_RADIUS -o - <(grim -g "$SLURP_RESULT" -) | wl-copy
    notify-send "Screenshot" "Captured screenshot into clipboard"
  else
    png_radius_strip -r $IMG_RADIUS -o - <(grim -g "$SLURP_RESULT" -) > "$DEFAULT_OUTPUT"
    notify-send "Screenshot" "Captured screenshot in \n$DEFAULT_OUTPUT"
  fi

  exit 0
fi

# Take the screenshot and save to clipboard if '-c' was passed in, otherwise
# save to default directory.
SLURP_RESULT="$(slurp ${SLURP_ARGS})"
if [[ "$SAVE_TO_CLIP" = "1" ]]; then
  grim -g "$SLURP_RESULT" - | wl-copy
  notify-send "Screenshot" "Captured screenshot into clipboard"
else
  grim -g "$SLURP_RESULT" - > "$DEFAULT_OUTPUT"
  notify-send "Screenshot" "Captured screenshot in \n$DEFAULT_OUTPUT"
fi

