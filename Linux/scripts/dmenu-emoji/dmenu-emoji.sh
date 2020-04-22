#!/bin/sh
# Give dmenu list of all unicode characters to copy.
# Shows the selected character in dunst if running.

# Must have xclip installed to even show menu.
echo -n | xclip -sel clipboard || exit

chosen=$(grep -v "#" ~/scripts/dmenu-emoji/emoji-list | rofi -dmenu -p "Emoji" \
                 -location 2 -width 20 \
		 -lines 20 -line-margin 0 -line-padding 1 \
		 -separator-style none -font "NotoColorEmoji 8" -columns 1 -bw 0 \
		 -hide-scrollbar \
		 -color-window "#002334, #002334, #002334" \
		 -color-normal "#00344E, #7F8C8D, #003140, #195A78, #FFFFFF" \
		 -color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
		 -color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
		 -kb-row-select "Tab" -kb-row-tab "" \
         -i)

[ "$chosen" != "" ] || exit

c=$(echo "$chosen" | sed "s/ .*//")
echo "$c" | tr -d '\n' | xclip -selection clipboard
notify-send "'$c' copied to clipboard." &

#s=$(echo "$chosen" | sed "s/.*; //" | awk '{print $1}')
#echo "$s" | tr -d '\n' | xclip
#notify-send "'$s' copied to primary." &

# dmenu_run -nf '#C8C8C8' -nb '#1D1D1D' 
#  -sb '#A569BD' -sf '#EEEEEE' -fn 'monospace-10' -p 'Apps:'
