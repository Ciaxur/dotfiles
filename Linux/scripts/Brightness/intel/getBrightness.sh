#!/bin/sh

# INTEL BACKLIGHT LOCATION & INFO
INTEL_DIR="/sys/class/backlight/intel_backlight/"
MAX_BRIGHT=$(cat $INTEL_DIR/max_brightness)
CUR_BRIGHT=$(cat $INTEL_DIR/brightness)
VAL_BRIGHT=$(echo "($CUR_BRIGHT / $MAX_BRIGHT) * 100" | bc)

echo "Max: $MAX_BRIGHT"
echo "Brightness: $CUR_BRIGHT"
echo "Val: $VAL_BRIGHT%"
