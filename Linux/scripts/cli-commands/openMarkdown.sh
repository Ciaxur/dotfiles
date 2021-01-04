#!/bin/sh

# Temporary Variable(s) Used
OUT_HTML="$(mktemp -u).html"
INPUT=$1

# Verify Arg
if [ "$1" == "" ]; then
  echo "Please enter Markdown file to open"
  exit 1
fi

# Convert File to HTML
pandoc -o $OUT_HTML $INPUT

# Open file using default Browser
gtk-launch "$(xdg-settings get default-web-browser)" $OUT_HTML

# Remove Temporary File
sleep 1 && rm $OUT_HTML
