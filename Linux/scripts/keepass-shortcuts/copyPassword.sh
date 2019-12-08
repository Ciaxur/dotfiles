#!/bin/sh

# Keep Variables
KEY_FILE=$1     # File to Open in Keepass
KEY_PATH=$2     # Path inside the Key Pass

# Alias Keepass for easy read
alias kp="keepassxc.cli"

# Function for Clearing Clipboard
clearClipboard() { 
    echo "" | tr -d '\n' | xclip -selection clipboard 
}

if [  "$KEY_FILE" = "" ] || [ "$KEY_PATH" = "" ]; then
    echo "Enter both the Key File and the Path to get password from"
    return 1
fi

printf "Enter Password: "
kp show $KEY_FILE $KEY_PATH | tee | grep -i password | awk 'END{print $2}' | tr -d '\n' | xclip -selection clipboard
printf "\nPassword for $KEY_PATH Copied to Clipboard!\n"

printf "In 5 seconds, clipboard will be cleared!\n"
(sleep 5; clearClipboard)&
return 0
