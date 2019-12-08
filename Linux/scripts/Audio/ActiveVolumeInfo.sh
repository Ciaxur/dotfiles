#!/bin/sh


# GET ACTIVE SINK
ACTIVE_Index=$(pacmd list-sinks 2> /dev/null | grep "* index" | awk '{print $3}')

# MAKE SURE PULSEAUDIO QUERY SUCCESS
if [ "$ACTIVE_Index" = "" ]; then
    echo ""
    exit 1
fi


# GET INDEX's INFO
INDEX_INFO=$(pacmd list-sinks 2> /dev/null | sed -n -e "/index: $ACTIVE_Index/,/index:/ p")

# GET VOLUME & MUTE
VOLUME=$(echo -e "$INDEX_INFO" | grep "volume:" | sed '1!d' | awk '{print $5}' | grep -o '[0-9]\+')
MUTED=$(echo -e "$INDEX_INFO" | grep "muted:" | awk '{printf $2}' | tr -d '\n')

# GET BLUETOOTH STATUS
RES=$(echo -e "$INDEX_INFO" | grep "bluetooth" -i | wc -l)

# SETUP EMOJI VARIABLES
BLUE_I=''
MUTED_I=' '
VOL0_I=''
VOL1_I=''
VOL2_I=''
VOL_I=''    # USED EMOJI



if [ "$MUTED" = "yes" ]; then
    echo "%{F#EC7063}$MUTED_I"
    exit 0
elif [ $RES -gt 0 ]; then                   # Blueooth Emoji
    VOL_I=$BLUE_I
elif [ $VOLUME -gt 60 ]; then               # Volume 60+
    VOL_I=$VOL2_I
elif [ $VOLUME -gt 35 ]; then               # Volume 35+
    VOL_I=$VOL1_I
else                                        # Volume <35
    VOL_I=$VOL0_I
fi

echo "$VOL_I %{F#CCC}$VOLUME%"
exit 0
