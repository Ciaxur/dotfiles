#!/bin/sh

# Runs a git fs check but prettifies it
function gflog() {
  git log --graph --oneline --decorate $(git fsck --no-reflogs | awk '/dangling commit/ {print $3}')
}

# Enables/Disables Nightmode
# Parameters are on/off
nightmode() {

    if [ "$1" = "-h" ]; then
        echo "Parameters: [on/off] to trigger nightmode"
    
    elif [ "$1" = "off" ]; then
        redshift -x        &>/dev/null
        echo "Turning off Nightmode"

    # Actual Value to set Redshift (Checks if Integer)
    elif [ $1 -eq $1 2>/dev/null ] && [ ! -z "$1" ]; then
        redshift -x        &>/dev/null
        redshift -O $1     &>/dev/null

        echo "Setting Nightmode to $1"
    else
        redshift -x        &>/dev/null
        redshift -O 3000   &>/dev/null
        
        echo "Setting Nightmode to '3000'"
    fi

}


# lf File Manager Function that
#  CD's into path from lf
lfcd() {
    # Run lf saving path
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp"

    # Make sure file path is found
    if [ -f "$tmp" ]; then
        dir="$(cat $tmp)"
        rm -f "$tmp"


        # CD into directory if not same as current
        #  and is an actual directory
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# nnn Function Invocation
nnncd() {
  TMP=/tmp/nnn.tmp
  FCOLORS='EEEEAAAF00000087005F8700FF'

  PLUGINS='f:fzcd;o:fzopen;h:hexview;d:diffs;i:mediainf;j:autojump'

  NNN_TMPFILE=$TMP TERMINAL=/bin/termite NNN_FCOLORS=$FCOLORS NNN_PLUG=$PLUGINS nnn -ade
  eval $(cat ${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd)
}

# Runs Local NPM Packages
function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }

# Creates a Temporary Directory in /tmp and cd's into it
#  storing the directory path into variable "CDTMP"
function cdtemp() {
  export CDTEMP=$(mktemp -d)
  cd $CDTEMP
}



