#!/bin/sh

SCRIPT_DIR=$(dirname $0)

# Source functions from other files.
alias wttr=$SCRIPT_DIR/functions/wttr.sh

# Docker Mini-function/aliases based on https://github.com/devemio/docker-color-output too
function di { docker images $@ | dco }
function dps { docker ps $@ | dco }
function dcps { docker-compose ps $@ | dco }


# Runs a git fs check but prettifies it
function gflog() {
  git log --graph --oneline --decorate $(git fsck --no-reflogs | awk '/dangling commit/ {print $3}')
}

# Enables/Disables Nightmode
# Parameters are on/off
nightmode() {
  # Add support for wayland.
  CMD="redshift"
  if [[ $XDG_BACKEND = "wayland" ]]; then
    CMD="gammastep"
  fi

  if [ "$1" = "-h" ]; then
    echo "Parameters: [on/off] to trigger nightmode or integer value to set temperature."
  elif [ "$1" = "off" ]; then
    $(${CMD} -x        &>/dev/null)&
    pkill $CMD
    echo "Turning off Nightmode"

  # Actual Value to set (Checks if Integer)
  elif [ $1 -eq $1 2>/dev/null ] && [ ! -z "$1" ]; then
    # Reset tempreature & kill background process.
    $(${CMD} -x        &>/dev/null)&
    pkill $CMD

    $(nohup ${CMD} -O $1     &>/dev/null)&
    disown

    echo "Setting Nightmode to $1"
  else
    $(${CMD} -x        &>/dev/null)&
    pkill $CMD

    $(nohup ${CMD} -O 3000   &>/dev/null)&
    disown

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

  # Configs are done through envs.
  #  https://github.com/jarun/nnn/wiki/Usage#configuration
  # FCOLORS='EEEEAAAF00000087005F8700FF'
  FCOLORS='c1e2272e006033f7c6d6abc4'
  PLUGINS='f:fzcd;o:fzopen;h:hexview;d:diffs;i:mediainf;j:autojump;p:preview-tui'
  FTERMINAL="/usr/bin/alacritty"

  NNN_PREVIEWIMGPROG="ueberzug" \
  NNN_FIFO="/tmp/nnn.fifo" \
  NNN_TMPFILE=$TMP \
  TERMINAL=$FTERMINAL\
  NNN_FCOLORS=$FCOLORS \
  NNN_PLUG=$PLUGINS \
    nnn -ade
  eval $(cat ${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd)
}

# Runs Local NPM Packages
function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }

# Creates a Temporary Directory in /tmp and cd's into it
#  storing the directory path into variable "CDTMP"
function cdtemp() {
  # Option variables.
  TEMPFS_SIZE="512M"

  # Handle Paramters
  # Print help
  if [ "$1" = "-h" ]; then
    printf "cdtemp\n"
    printf "Creates a Temporary Directory and CD's into it\n"
    printf "Temporary Direcory stored under variable: $$CDTTEMP\n"

    printf "\nUSAGE:\n"
    printf "  cdtemp [OPTIONS]\n"

    printf "\nOPTIONS:\n"
    printf "  -h \t\t Prints help information\n"
    printf "  -r \t\t Removes CDTEMP directory created (if any)\n"
    printf "  --tempfs \t Creates a tempfs directory\n"

  # Remove temporary directory
  elif [ "$1" = "-r" ]; then
    if [ "$CDTEMP" != "" ]; then

      # Check if temp direcotry is a tempfs mount.
      if [ "$(mount | grep -E "$CDTEMP.*tmpfs")" ]; then
        # change the current directory since resource would be busy.
        cd /tmp
        echo "Unmounting tempfs..."
        sudo umount "$CDTEMP"
      fi

      printf "Removing Temporary Directory $CDTEMP...\n"
      rm -rf $CDTEMP || return
      unset CDTEMP
    else
      printf "No CDTEMP created to remove\n"
    fi

  # Create a tempfs temporary directory.
  elif [ "$1" = "--tempfs" ]; then
    export CDTEMP=$(mktemp -d)
    echo "Mounting tempfs(size=$TEMPFS_SIZE) on '$CDTEMP'..."
    sudo mount -t tmpfs -o size=$TEMPFS_SIZE tempfs "$CDTEMP"
    cd $CDTEMP

  # Create and cd into that temp directory.
  else
    export CDTEMP=$(mktemp -d)
    cd $CDTEMP
  fi
}


function whatsmyip() {
  IP=$(curl -s 'https://api.ipify.org?format=json' | jq '.ip')
  printf "My Public IP is $IP\n";
}


