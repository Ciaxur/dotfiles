#!/bin/sh

# LIST ACTIVE SINK INFO
pacmd list-sinks | sed -n -e '/* index:/,/index:/ p'
