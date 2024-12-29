#!/usr/bin/env bash

# Grab currently playing song.
spotify_metadata=$(qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata)
song=$(echo "$spotify_metadata" | rg 'title: (.*)' -or '$1')
artist=$(echo "$spotify_metadata" | rg 'artist: (.*)' -or '$1')

[ "$song" = "" ] && { echo "No song playing."; exit 1; }

# Construct genius url.
url_song=$(echo $song | sed 's/\s/-/g')
url_artist=$(echo $artist | sed 's/\s/-/g')
url_genius="https://genius.com/$url_artist-$url_song-lyrics"

curl -sL "$url_genius" | htmlq 'div[data-lyrics-container="true"]' | sed 's/<br>/\n/g' | htmlq --text
