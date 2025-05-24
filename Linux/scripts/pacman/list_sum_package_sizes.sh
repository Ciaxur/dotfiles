#!/usr/bin/env bash
set -e

function convert_to_bytes() {
  VALUE="$1"
  NUM=$(echo "$VALUE" | cut -d' ' -f1)
  SIZE_TYPE=$(echo "$VALUE" | cut -d' ' -f2)

  VALUE_IN_BYTES=0
  if [[ "$SIZE_TYPE" = "KiB" ]]; then
    VALUE_IN_BYTES=$(echo "scale=0; $NUM * 1024" | bc )
  elif [[ "$SIZE_TYPE" = "MiB" ]]; then
    VALUE_IN_BYTES=$(echo "scale=0; $NUM * 1024 * 1024" | bc )
  elif [[ "$SIZE_TYPE" = "GiB" ]]; then
    VALUE_IN_BYTES=$(echo "scale=0; $NUM * 1024 * 1024 * 1024" | bc )
  fi

  echo "$VALUE_IN_BYTES"
}
export -f convert_to_bytes

pacman -Qi | \
  rg 'Size\s+: (\d+.*)' -or '$1' | \
  xargs -P69 -I{} bash -c "convert_to_bytes '{}'" | \
  awk '{ sum += $1 } END { print sum / 1024 / 1024 / 1024, "GiB" }'

