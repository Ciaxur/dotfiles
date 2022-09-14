#!/bin/sh
# Author: Omar Omar
#
# Simple Script Used to Update files 
#  based on Source and Target Path
# Requires a Text file that tells the script
#  which files/dirs to check for

# Parse optional arguments.
DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run)
      DRY_RUN=1
      echo "Enabled Dry run toggled."
      shift # past argument
      ;;
    *)
      # Ignore unknown argument.
      shift
      ;;
  esac
done


# PATHS TO CHECK (MUST BE ABSOUTE, for guarenteed success!)
source_path="/home/omar"
target_path="/home/omar/Documents/git-clones/dotfiles/Linux"
filesUsed_file="filesUsed.txt"

# MOVE ALL SPECIFIED FILES/DIRS FROM TEXTFILE
if [ -f $filesUsed_file ]; then
  echo "Comparing..."
  while read path; do
    # Split on Delimeter for Customer Source->Target Path
    IFS=":" read -a pathArr <<< $path

    # Ignore comments and empty lines.
    if [[ "$pathArr" == \#* ]] || [[ "$pathArr" == "" ]]; then
      continue
    fi

    # Specify Correct Paths
    source="$source_path/$pathArr"          # Pick first Path from PathArr

    # Check for Custom Path
    if [ ${#pathArr[@]} = 2 ]; then
      target="$target_path/${pathArr[1]}"
    else
      target="$target_path/$pathArr"
    fi

    # Verbose Output
    printf "Source [$source]\n" 
    printf "    ↳ Target [$target]\n"
    
    # Make sure Necessary Directories Created
    prevPath=$(dirname $target)
    if [ $DRY_RUN = 0 ]; then
      if [ ! "$prevPath" = "$target_path" ]; then
        mkdir -p $prevPath
        cp -ru $source $prevPath
      else
        cp -ru $source $target
      fi
    fi
  done < filesUsed.txt

else
  echo "Please create a 'filesUsed.txt' to use."
fi
