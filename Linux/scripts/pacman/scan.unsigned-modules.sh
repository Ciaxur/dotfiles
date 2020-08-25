#!/bin/sh

for mod in $(lsmod | tail -n +2 | cut -d ' ' -f1); do

  ( modinfo ${mod} | grep -q "signature" && echo "Module '${mod}' Signed!" ) || echo "No Signature for Module: ${mod}"

done
