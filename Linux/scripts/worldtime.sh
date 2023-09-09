#!/usr/bin/env bash

# Simple script which lists tracked times across the world.
LEB_TIME=$(TZ=EET date)
MI_TIME=$(TZ=":US/Eastern" date)
JP_TIME=$(TZ=":Asia/Tokyo" date)
LOCAL_TIME=$(date)

echo -e "\033[1mLocal Time:   \033[0m $LOCAL_TIME"
echo -e "\033[1mLebanon Time: \033[0m $LEB_TIME"
echo -e "\033[1mMichigan Time:\033[0m $MI_TIME"
echo -e "\033[1mJapan Time:   \033[0m $JP_TIME"
