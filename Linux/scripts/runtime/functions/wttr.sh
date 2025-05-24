#!/usr/bin/env bash

# Define a function to display usage information
usage() {
  echo "Usage: $0 [argument]"
  echo "By default, display the current weather or pass in unsupported arguments"
  echo "to wttr.in."
  echo ""
  echo "  -h or --help         Display this help message"
  echo "   help                Displays the help menu of wttr.in"
  echo "   day                 Displays the current day's forecast"
  echo "   tomorrow            Displays the today and tomorrow's forecast"
}

# Weather helper function which uses the wttr.in api.
function wttr() {
  URI="https://wttr.in"
  CMD="$1"

  # Handle translating cli args to wttr url-encoded args.
  case "$CMD" in
    help)
      CMD=":help"
      ;;
    day)
      CMD="?1&m"
      ;;
    tomorrow)
      CMD="?2&m"
      ;;
  esac


  # wttr is a cool weather project:
  # This func serves as a mini-alias for quick weather requests.
  # By default, use these default options.
  URL="${URI}/${CMD:=?0&m}"
  curl -s $URL
}


# Process command-line options using a case statement
FORWARDED_ARG=""
while [[ ! -z "$1" ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    *)
      FORWARDED_ARG="$1"
  esac
  shift
done


# Main entrypoint.
wttr $@ $FORWARDED_ARG
