#!/usr/bin/env bash

# Toggling waybar via signals
# SIGUSR1 -> toggle
# SIGUSR2 -> reload
pkill -SIGUSR1 waybar

