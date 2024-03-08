#!/bin/bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
killall xwaylandvideobridge

# Configure clean up trap.
function cleanup() {
  set +e
  echo "Cleaning up processes..."
  killall -e xdg-desktop-portal-hyprland
  killall -e xdg-desktop-portal-wlr
  killall xdg-desktop-portal
  killall xwaylandvideobridge
}
trap 'cleanup' SIGINT

# Export envs.
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland
export QT_AUTO_SCREEN_SCALE_FACTOR=1

LOG_FILEPATH="/tmp/xdp-hyprland.log"


echo "Starting hyprland portal..."
/usr/lib/xdg-desktop-portal-hyprland 2>&1 | tee "$LOG_FILEPATH" &

echo "Waiting 2s for hyprland portal to start..."
sleep 2
/usr/lib/xdg-desktop-portal -v 2>&1 | tee -a "$LOG_FILEPATH" &

#echo "Starting XWayland Video Bridge..."
#sleep 1
#xwaylandvideobridge 2>&1 | tee -a "$LOG_FILEPATH" &

echo "Waiting for interrupt..."
wait
