#!/bin/sh

# Clears the Clipboard
echo "" | tr -d '\n' | xclip -selection clipboard
