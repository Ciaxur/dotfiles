#!/bin/sh
# GNU Screen Module

SCREEN_NUM=$(bc <<< "$(screen -ls | wc -l) - 2")

if [ $SCREEN_NUM != 0 ]; then
  echo "💻[$SCREEN_NUM]"
fi
