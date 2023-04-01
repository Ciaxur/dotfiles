#!/bin/sh
xrandr \
  --output DP-1 --off \
  --output DP-2 --mode 2560x1440 --pos 4000x658 --rotate normal \
  --output HDMI-1 --off \
  --output DP-3 --primary --mode 2560x1440 --pos 1440x658 --rotate normal \
  --output HDMI-2 --off \
  --output DP-4 --mode 2560x1440 --pos 0x0 --rotate left \
  --output HDMI-3 --off
