#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Get Current Directory Full Path
CURR_DIR=`dirname $0`

# Must have xclip installed to even show menu.
echo -n | xclip -sel clipboard || exit

chosen=$(grep -v "#" ~/scripts/dmenu-emoji/emoji-list | rofi -dmenu -p "Emoji" \
	-theme "$CURR_DIR/Theme.rasi" \
	-location 2 -width 20 \
	-lines 20 -line-margin 0 -line-padding 1 \
	-separator-style none -font "JoyPixels 8" -columns 1 -bw 0 \
	-hide-scrollbar \
	-i)

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send -a "Emoji Menu" "'$c' copied to clipboard." -i "$CURR_DIR/pericles.png" &

