#!/bin/sh

# Get Current Directory Full Path
CURR_DIR=`dirname $0`

chosen=$(grep -v "#" $CURR_DIR/help-list | rofi -dmenu -p "Help Menu" \
                 -location 4 -width 15 \
		 -lines 40 -line-margin 0 -line-padding 1 \
		 -separator-style none -font "JoyPixels 10" -columns 1 -bw 0 \
		 -hide-scrollbar \
		 -color-window "#002334, #002334, #002334" \
		 -color-normal "#00344E, #7F8C8D, #003140, #195A78, #FFFFFF" \
		 -color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
		 -color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
		 -kb-row-select "Tab" -kb-row-tab "" \
         -i)

