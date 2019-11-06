#!/bin/sh

i3lock -n -t -i $(find ~/Pictures/LockScreen/ -name "*.*" | shuf -n1) \
    --insidecolor=37344500 --ringcolor=ffffffff --line-uses-inside \
    --keyhlcolor=3CADD2FF --bshlcolor=d23c3dff --separatorcolor=00000000 \
    --insidevercolor=3CD282FF --insidewrongcolor=d23c3dff \
    --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+86:y+1003" \
    --radius=18 --veriftext="" --wrongtext=""
