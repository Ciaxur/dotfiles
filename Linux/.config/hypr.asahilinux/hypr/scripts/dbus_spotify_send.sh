#!/bin/bash

set -euo pipefail

case "${1:-}" in
  next)
    MEMBER=Next
    ;;

  previous)
    MEMBER=Previous
    ;;

  play)
    MEMBER=Play
    ;;

  pause)
    MEMBER=Pause
    ;;

  play-pause)
    MEMBER=PlayPause
    ;;

  *)
    echo "Usage: $0 next|previous|play|pause|play-pause"
    exit 1
    ;;

esac

# Grab spotify instance.
SPOTIFY_INSTANCE=$(playerctl -l | rg spotify)

exec dbus-send                                                \
  --print-reply                                               \
  --dest="org.mpris.MediaPlayer2.$SPOTIFY_INSTANCE" \
  /org/mpris/MediaPlayer2                                     \
  "org.mpris.MediaPlayer2.Player.$MEMBER"
