#!/usr/bin/env bash
set -e

# Requires the cursor theme name and size.
CURSOR_NAME="$1"
CURSOR_SIZE="$2"

[ -e $CURSOR_NAME ] && { echo "Cursor name required as a 1st argument!"; exit 1; }
[ -e $CURSOR_SIZE ] && { echo "Cursor size required as a 2nd argument!"; exit 1; }


# Grab available cursors on the system.
AVAIL_CURSORS=`
find /usr/share/icons ~/.local/share/icons ~/.icons -type d -name "cursors" | \
  xargs -I{} bash -c 'basename $(dirname {})' | \
  sort -u
`

function print_avail_cursors() {
  echo -e "= Available cursors=\n$AVAIL_CURSORS"
}

FOUND=0
for cursor in $AVAIL_CURSORS; do
  if [[ "$CURSOR_NAME" = "$cursor" ]]; then
    FOUND=1
    break
  fi
done

[ $FOUND == 0 ] && { echo "Cursor '$CURSOR_NAME' not found"; print_avail_cursors; exit 1; }

# Update hyprland
hyprctl setcursor $CURSOR_NAME $CURSOR_SIZE
