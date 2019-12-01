#!/bin/sh

# INTEL BACKLIGHT LOCATION & INFO
INTEL_DIR="/sys/class/backlight/intel_backlight/"
MAX_BRIGHT=$(cat $INTEL_DIR/max_brightness)
CUR_BRIGHT=$(cat $INTEL_DIR/brightness)
VAL_BRIGHT=$(echo "scale=1;( ($CUR_BRIGHT / $MAX_BRIGHT) * 100.0 )" | bc)
VAL_BRIGHT=$(printf "%.0f" $VAL_BRIGHT)

echo "$VAL_BRIGHT%"
