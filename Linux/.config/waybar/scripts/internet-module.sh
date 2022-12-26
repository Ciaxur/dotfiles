#!/bin/sh

##################
# ICON VARIABLES #
#  kcharselect   #
##################
WIFI_I=''
ETH_I=''
AIRPLAINE_I='✈'


# Obtain Connection Information
CONX_INFO=$(nmcli d | grep -iw connected)
AIRPLANE_MODE=$(nmcli g | sed -n 2p | awk '{print $4}')

# Validate Connection Found
if [ "$AIRPLANE_MODE" = "disabled" ]; then
    echo "%{F#FFF}$AIRPLAINE_I"
    exit 0
elif [ "$CONX_INFO" = "" ]; then
    echo ""
    exit 1
fi

# Get rest of Information
CONX_BSSID=`echo $CONX_INFO | awk '{print $4}'`
CONX_TYPE=`echo $CONX_INFO | awk '{print $2}'`
CONX_VPN=`echo $CONX_INFO | grep -Po 'tun[\d+]'`

# Adjust Connection Type
if [ "$CONX_TYPE" = "wifi" ]; then
    # Color based on Signal Strength
    strength=$(nmcli dev wifi | grep -i '*' | awk '{print $8}')

    if (( $strength > 80 )); then       # Strong
        CONX_TYPE="%{F#EEE}$WIFI_I"
    elif (( $strength > 40 )); then     # Medium
        CONX_TYPE="%{F#BBB}$WIFI_I"
    else                                # Low
        CONX_TYPE="%{F#888}$WIFI_I"
    fi



elif [ "$CONX_TYPE" = "ethernet" ]; then
    CONX_TYPE="$ETH_I"
fi

# Adjust for VPN Connection
if [ ${#CONX_VPN} -gt 0 ]; then
  CONX_VPN="[VPN]"
fi

# Output Information with Fromatting
echo "$CONX_TYPE$CONX_VPN $CONX_BSSID"
