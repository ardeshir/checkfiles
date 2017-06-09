#!/bin/bash
#
# Perform some operation to all the files in a directory
# shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY=$1
declare DIR="initscripts"

copy_current_uniq() {
cat "current_application_metadata"    |  uniq >> "$DIR/application_metadata_t"
sort -u "$DIR/application_metadata_t" |  uniq >  "$DIR/application_metadata" 
}

if [[ ! -d "$DIR" &&  ! -x "$DIR" ]]; then 
   mkdir "$DIR"
fi

copy_current_uniq

rm "$DIR/application_metadata_t" 

exit 0
