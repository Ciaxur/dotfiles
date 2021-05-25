#!/bin/sh

# GET SCREEN
chosen=$(screen -ls | grep -iPo '\d+\..*\s' | rofi -dmenu -p "Screens" -i \
  -width 25 \
  -font 'SF Compact 10' \
  -theme solarized \
  -seperator-style none \
  -columns 1 \
  -bw 0)

[ "$chosen" != "" ] || exit
echo "$chosen" | tr -d '\n' | tr -d '[:space:]' | xclip -selection clipboard
echo "$chosen Copied to clipboard"

