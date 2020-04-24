#!/bin/sh

echo $(cut -c 1-3 /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | sed -e 's/[0-9]/&./')GHz
