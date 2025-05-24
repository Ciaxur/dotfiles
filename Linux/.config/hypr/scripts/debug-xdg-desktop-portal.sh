#!/bin/bash
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal

# Configure clean up trap.
function cleanup() {
  set +e
  echo "Cleaning up processes..."
  killall -e xdg-desktop-portal-hyprland
  killall -e xdg-desktop-portal-wlr
  killall xdg-desktop-portal


  echo "Cleaning up FIFOs..."
  rm p1_fifo p2_fifo
}
trap 'cleanup' SIGINT

# Make FIFO pipes.
set -e
mkfifo p1_fifo
mkfifo p2_fifo

# Export envs.
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland
export QT_AUTO_SCREEN_SCALE_FACTOR=1


echo "Starting hyprland portal..."
/usr/lib/xdg-desktop-portal-hyprland > p1_fifo &
cat < p1_fifo | sed 's/^/hyprland-portal: /' | bat -llog -P &

echo "Waiting 2s for hyprland portal to start..."
sleep 2
/usr/lib/xdg-desktop-portal -v > p2_fifo &
cat < p2_fifo | sed 's/^/desktop-portal: /' | bat -llog -P &


echo "Waiting for interrupt..."
wait
