#!/bin/sh

# Help Function
print_help() {
    echo "Compress Given File to Output"
    echo "- First parameter is Input PDF"
    echo "- Second parameter is Output PDF"
}

# Verify Input :)
if [ "$1" = "-h" ] || [ "$1" = "" ] || [ "$2" = "" ]; then
    print_help
    exit 1
fi


# Preceed with Compression
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
       -dNOPAUSE -dBATCH  -dQUIET -sOutputFile=$2 $1

exit 0
