#!/bin/sh

# Obtain Connection Information
CONX_INFO=$(nmcli d | grep -iw connected)

# Validate Connection Found
if [ "$CONX_INFO" = "" ]; then
    echo ""
    exit 1
fi

# Get rest of Information
CONX_BSSID=`echo $CONX_INFO | awk '{print $NF}'`
CONX_TYPE=`echo $CONX_INFO | awk '{print $2}'`


# Adjust Connection Type
if [ "$CONX_TYPE" = "wifi" ]; then
    CONX_TYPE="WLAN"

elif [ "$CONX_TYPE" = "ethernet" ]; then
    CONX_TYPE="ETH"
fi

# Output Information with Fromatting
echo "%{F#999}$CONX_TYPE %{F#FFF}$CONX_BSSID"
