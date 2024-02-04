#!/usr/bin/env bash

# This script is a wrapper to ensure shotman processes don't remain running in
# the background after being invoked.
TIMEOUT_S=45

CAPTURE_TYPE="$1"
[ "$CAPTURE_TYPE" == "" ] && { echo "Capture type not passed in."; shotman -h; exit 1; }

shotman --capture "$CAPTURE_TYPE" -C &
SHOTMAN_PID="$!"
echo "Waiting for $SHOTMAN_PID"

# Wait some arbitrary time
sleep $TIMEOUT_S

# Terminate the process and wait for it to die
ps -p $SHOTMAN_PID || { echo "Shotman process died"; exit 0; }
kill $SHOTMAN_PID
wait $SHOTMAN_PID

