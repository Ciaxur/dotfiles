#!/usr/bin/env bash

package_name="$1"
[ "$1" == "" ] && { echo "Please enter package name"; exit 1; }

# "pacman -Sp <package-name>": Grabs tarball URL for package.
# "pacman -Qlp <package-name>": Lists file content of a given tarball.
pacman -Qlp <(curl -s $(pacman -Sp "$package_name"))
