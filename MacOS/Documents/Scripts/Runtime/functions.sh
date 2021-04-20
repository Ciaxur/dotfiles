#!/bin/sh


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


