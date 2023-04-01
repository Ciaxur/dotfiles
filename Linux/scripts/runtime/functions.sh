#!/bin/sh


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

  # Handle Paramters
  # PRINT HELP
  if [ "$1" = "-h" ]; then
    printf "cdtemp\n"
    printf "Creates a Temporary Directory and CD's into it\n"
    printf "Temporary Direcory stored under variable: $$CDTTEMP\n"

     printf "\nUSAGE:\n"
    printf "  cdtemp [OPTIONS]\n"

    printf "\nOPTIONS:\n"
    printf "  -h \t\t Prints help information\n"
    printf "  -r \t\t Removes CDTEMP directory created (if any)\n"


  # REMOVE CDTEMP
  elif [ "$1" = "-r" ]; then

    if [ "$CDTEMP" != "" ]; then
      printf "Removing Temporary Directory $CDTEMP...\n"
      rm -rf $CDTEMP
      unset CDTEMP
    else
      printf "No CDTEMP created to remove\n"
    fi

  # CREATE AND CD INTO TEMP DIRECTORY
  else
    export CDTEMP=$(mktemp -d)
    cd $CDTEMP
  fi
}


function whatsmyip() {
  IP=$(curl -s 'https://api.ipify.org?format=json' | jq '.ip')
  printf "My Public IP is $IP\n";
}


function wttr() {
  URI="https://wttr.in"

  if [[ "$1" == "help" ]]; then
    1=":help"
  fi
  

  # wttr is a cool weather project:
  # This func serves as a mini-alias for quick weather requests.
  # By default, use these default options.
  URL="${URI}/${1:=?0&m}"
  curl -s $URL
}

