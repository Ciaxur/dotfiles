#!/usr/bin/env bash
SCRIPT_DIR=$(dirname $0)

# Only trigger on play events.
[ "$PLAYER_EVENT" = "play" ] || exit 0

# Grab spotify metadata from dbus.
# Query once.
SPOTIFY_INSTANCE=$(playerctl -l | rg spotify)
DBUS_METADATA=$(qdbus org.mpris.MediaPlayer2.$SPOTIFY_INSTANCE /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata) \
  || { echo "Failed to query $SPOTIFY_INSTANCE metadata"; exit 1; }

TITLE=$(echo "$DBUS_METADATA" | rg 'title: (.*)$' -or '$1')
ALBUM=$(echo "$DBUS_METADATA" | rg 'album: (.*)$' -or '$1')
ARTIST=$(echo "$DBUS_METADATA" | rg 'artist: (.*)$' -or '$1')


# Construct song info notification.
song="Title: $TITLE\nArtist: $ARTIST\nAlbum: $ALBUM"

# Grab song ablum art.
ALBUM_ART_FILEPATH="/tmp/spotify-album-art-icon.png"
$SCRIPT_DIR/queryAlbumArtDbus.sh $ALBUM_ART_FILEPATH

# Yeet a notification.
notify-send "Spotify" "$song" --icon=$ALBUM_ART_FILEPATH

