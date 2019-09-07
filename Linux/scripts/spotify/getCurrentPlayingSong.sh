#!/bin/sh

# DEBUG MODE
DEBUG=0



###################################
# Obtain data and Store into Temp #
###################################
TMP_FILE=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata > /tmp/$TMP_FILE


###################################
# Store Seperate data in Vars     #
###################################
LENGTH=$(cat /tmp/$TMP_FILE | grep length | cut -d ' ' -f2-)
ALBUM=$(cat /tmp/$TMP_FILE | grep -iw "album" | cut -d ' ' -f2-)
ARTIST=$(cat /tmp/$TMP_FILE | grep -iw "artist" | cut -d ' ' -f2-)
SONG=$(cat /tmp/$TMP_FILE | grep -iw "title" | cut -d ' ' -f2-)


#######################################
# Convert Microseconds to Human Time  #
#######################################
MICRO_SEC=$LENGTH
MIN=$(( $MICRO_SEC / 60000000 ))
SEC=$(( ($MICRO_SEC - ($MIN * 60000000)) / 1000000  ))

######################
# Output for Polybar #
######################
echo "%{F#5DADE2}[ $SONG - $ARTIST ]"


####################
# Debuggin Section #
####################
if [ $DEBUG = 0 ];then
    return 0
fi

printf "Lenth: "
if [ $SEC -lt 10 ]; then
    echo "$MIN:0$SEC"
else
    echo "$MIN:$SEC"
fi



echo "Song: $SONG"
echo "Album: $ALBUM"
echo "Artist: $ARTIST"
