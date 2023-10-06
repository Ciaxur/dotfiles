#!/usr/bin/env bash

# Query available displays.
mapfile -t DISPLAYS < <(swww query | awk '{print $1}' | tr -d ":")

# Apply a random image to each display.
for display in "${DISPLAYS[@]}"; do
  swww img "$(find ~/pictures/background/ -name "*.*" | shuf -n1)" \
    --outputs "$display" \
    -t random \
    --transition-duration 2
done
