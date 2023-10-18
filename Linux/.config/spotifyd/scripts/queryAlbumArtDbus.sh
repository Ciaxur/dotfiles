#!/bin/bash
set -e

# Expects a filepath for which to save the album art to.
ALBUM_ART_FILEPATH="$1"

[ "$ALBUM_ART_FILEPATH" = "" ] && { echo "No album art save filepath argument given!"; exit 1; }

# The album art is actually within the dbus metadata.
SPOTIFY_INSTANCE=$(playerctl -l | rg spotify)
ALBUM_ART_URL=$(qdbus org.mpris.MediaPlayer2.$SPOTIFY_INSTANCE /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | rg -o 'artUrl: (.*)$' -r '$1')

curl -sL $ALBUM_ART_URL -o $ALBUM_ART_FILEPATH
echo "Saved album art '$ALBUM_ART_URL' -> $ALBUM_ART_FILEPATH"

