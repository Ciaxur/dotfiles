#!/bin/sh

# DEBUG MODE
DEBUG=0


###############################
# SPOTIFY ICON (Iosevka Font) #
###############################
ICON=''
SONG_LEN_MAX=35
PAUSE_ICON=''
PLAY_ICON=''


###################################
# Obtain data and Store into Temp #
###################################
TMP_FILE="Spotify.cLB6HKS25q8F"
qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata > /tmp/$TMP_FILE 2>&1

##############################
# Make sure music is playing #
##############################
if [ $(cat /tmp/$TMP_FILE | wc -l) -lt 9 ];then
    echo ""
    exit 0
fi


###################################
# Store Seperate data in Vars     #
###################################
LENGTH=$(grep length /tmp/$TMP_FILE | cut -d ' ' -f2-)
ALBUM=$(grep -iw "album" /tmp/$TMP_FILE | cut -d ' ' -f2-)
ARTIST=$(grep -iw "artist" /tmp/$TMP_FILE | cut -d ' ' -f2-)
SONG=$(grep -iw "title" /tmp/$TMP_FILE | cut -d ' ' -f2-)


#################################
# Make sure Valid Data is found #
#################################
if [ "$ALBUM" = "" ] || [ "$SONG" = "" ] ;then
    echo "%{F#5DADE2}[ %{F#1DB954}$ICON %{F#999}Spotify %{F#5DADE2}]"
    exit 0

# Limit the Song String to Variable Character Length
elif [ "$(expr length "$SONG")" -gt $SONG_LEN_MAX ];then
    SONG="$(echo $SONG | cut -c1-$SONG_LEN_MAX)..."
fi



#######################################
# Get Play/Pause Status               #
#######################################
PLAYBACK_QUERY=`qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus`
PLAY_STATUS=$PLAY_ICON
[[ $PLAYBACK_QUERY = "Playing" ]] && PLAY_STATUS="$PLAY_ICON" || PLAY_STATUS="$PAUSE_ICON"


#######################################
# Convert Microseconds to Human Time  #
#######################################
MICRO_SEC=$LENGTH
MIN=$(( $MICRO_SEC / 60000000 ))
SEC=$(( ($MICRO_SEC - ($MIN * 60000000)) / 1000000  ))

######################
# Output for Polybar #
######################
if [ "$ARTIST" = "" ]; then # No Artist, this is a Podcast
  echo "$ICON [ $SONG - (Podcast) $PLAY_STATUS  ]"
else
  echo "$ICON [ $SONG - $ARTIST  $PLAY_STATUS  ]"
fi


####################
# Debuggin Section #
####################
if [ $DEBUG = 0 ];then
    exit 0
fi

printf "Length: "
if [ $SEC -lt 10 ]; then
    echo "$MIN:0$SEC"
else
    echo "$MIN:$SEC"
fi


echo "Song: $SONG"
echo "Album: $ALBUM"
echo "Artist: $ARTIST"
