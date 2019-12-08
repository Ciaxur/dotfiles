#!/bin/sh
# Author: Omar Omar
#
# Simple Script Used to Update files 
#  based on Source and Target Path
# Requires a Text file that tells the script
#  which files/dirs to check for


# PATHS TO CHECK (MUST BE ABSOUTE, for guarenteed success!)
source_path="/home/omar"
target_path="/home/omar/documents/git-clones/dotfiles/Linux"
filesUsed_file="filesUsed.txt"

# MOVE ALL SPECIFIED FILES/DIRS FROM TEXTFILE
if [ -f $filesUsed_file ]; then
    echo "Comparing..."
    while read path; do
        source="$source_path/$path"
        target="$target_path/$path"

        
        printf "Source [$source] \t Target [$target]\n"
        
        # Make sure Necessary Directories Created
        prevPath=$(dirname $target)
        if [ ! "$prevPath" = "$target_path" ]; then
            mkdir -p $prevPath
            cp -ru $source $prevPath
        else
            cp -ru $source $target
        fi
    done < filesUsed.txt

else
    echo "Please create a 'filesUsed.txt' to use."
fi
