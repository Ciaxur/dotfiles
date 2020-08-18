#!/bin/sh

# Lists Orphaned Packaged (Unused)
#  Q - Query Packages
#  d - Dependancies
#  t - Not Required by any Package
pacman -Qdt
