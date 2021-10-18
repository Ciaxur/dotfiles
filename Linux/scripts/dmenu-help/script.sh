#!/bin/sh

# Get Current Directory Full Path
CURR_DIR=`dirname $0`

chosen=$(grep -v "#" $CURR_DIR/help-list | rofi -dmenu -p "Help Menu" \
	-theme "$CURR_DIR/Theme.rasi" \
	-location 4 -width 15 \
	-lines 40 -line-margin 0 -line-padding 1 \
	-separator-style none -font "JoyPixels 10" -columns 1 -bw 0 \
	-hide-scrollbar \
	-kb-row-select "Tab" -kb-row-tab "" \
	-i)

