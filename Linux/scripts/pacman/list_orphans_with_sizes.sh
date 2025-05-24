#!/usr/bin/env bash

pacman -Qqt | xargs -P69 -I{} bash -c "pacman -Qi {} | rg '(Name|Size)\s+: (\d+.*)' -or '\$2 ({})'"
