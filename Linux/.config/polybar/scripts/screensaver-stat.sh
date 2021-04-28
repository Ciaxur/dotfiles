#!/bin/sh

STATUS=$(xset q | sed -rn 's/prefer blanking:\s*(yes|no).*/\1/p' | tr -d ' ')
ICON=""   # Assume it's OFF

# Set Correct Emoji
if [ $STATUS = "no" ]; then
  ICON="%{F#FFF}🐼"
fi
echo $ICON
