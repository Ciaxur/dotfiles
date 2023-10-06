#!/bin/sh

swaylock -n -t -i $(find ~/Pictures/Background/ -name "*.*" | shuf -n1) \
    --line-uses-inside \
    --indicator-radius=18
