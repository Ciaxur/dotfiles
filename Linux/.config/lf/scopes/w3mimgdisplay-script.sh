#!/bin/bash
#
# z3bra -- 2014-01-21
# http://blog.z3bra.org/2014/01/images-in-terminal.html

test -z "$1" && exit


#!/bin/sh

# GET INPUT INFO
FILENAME=$1
BASENAME=$(basename -- "$FILENAME")
EXTENSION="${BASENAME##*.}"

# CHECKS IF VAL IN ARRAY
function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

# VALID EXTENTIONS
VALID_EXT=("png" "jpg" "jpeg")


if [ $(contains "${VALID_EXT[@]}" $EXTENSION) == "y" ]; then
    W3MIMGDISPLAY="/usr/lib/w3m/w3mimgdisplay"
    FONTH=14 # Size of one terminal row
    FONTW=8  # Size of one terminal column
    COLUMNS=`tput cols`
    LINES=`tput lines`

    read width height <<< `echo -e "5;$FILENAME" | $W3MIMGDISPLAY`

    max_width=$(($FONTW * $COLUMNS/3))
    max_height=$(($FONTH * $(($LINES - 2)))) # substract one line for prompt

    if test $width -gt $max_width; then
        height=$(($height * $max_width / $width))
        width=$max_width
    fi
    if test $height -gt $max_height; then
        width=$(($width * $max_height / $height))
        height=$max_height
    fi

    x=$((COLUMNS * 3 + 34))
    y=$((LINES   * 1))

    #w3m_command="0;1;0;0;$width;$height;;;;;$FILENAME\n4;\n3;"
    w3m_command="0;1;$x;$y;$width;$height;;;;;$FILENAME\n4;\n3;"
    

    tput cup $(($height/$FONTH)) 0
    echo -e $w3m_command|$W3MIMGDISPLAY

else
    cat $FILENAME
fi
