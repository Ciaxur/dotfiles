#!/usr/bin/env bash

# Grab the log location if present.
LOG_FILEPATH=${1:-/dev/stdout}
echo "Redirecting stdout to $LOG_FILEPATH" | tee -a $LOG_FILEPATH

# Query available displays.
mapfile -t DISPLAYS < <(swww query | awk '{print $1}' | tr -d ":")
echo "Queried available screens: ${DISPLAYS[@]}" | tee -a $LOG_FILEPATH

# Apply a random image to each display.
for display in "${DISPLAYS[@]}"; do
  swww img "$(find ~/pictures/background/ -name "*.*" | shuf -n1)" \
    --outputs "$display" \
    -t random \
    --transition-duration 2 | tee $LOG_FILEPATH
done

echo "Wallpaper set" | tee -a $LOG_FILEPATH
