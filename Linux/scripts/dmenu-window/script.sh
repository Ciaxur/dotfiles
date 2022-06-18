#!/bin/sh

# Get Current Directory Full Path
CURR_DIR=`dirname $0`

rofi -show window \
	-theme "$CURR_DIR/Theme.rasi" \
	-location 4 -width 15 \
	-lines 40 -line-margin 0 -line-padding 1 \
	-separator-style none -font "Adelle 8" -columns 1 -bw 0 \
	-hide-scrollbar \
	-kb-row-select "Tab" -kb-row-tab ""

