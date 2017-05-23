#!/bin/bash
#
# Perform some operation to all the files in a directory

shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY="."

ls -1 "$INCOMING_DIRECTORY" |
  (
    while read FILE ; do
       #printf "$SCRIPT: Processing %s...\n" "$FILE"
 curr=false  old=false      
       # <-- do something here
       
       if [[ $FILE = "current_application_metadata" ]]; then
           printf "Current App meta: %s \n" "$FILE"
           #curr=false
       fi
       if [[ $FILE = "application_metadata" ]]; then
          printf "Application meta: %s \n" "$FILE"
          #old=false
       fi
       
        # <-- do more stuff knowing we have curr or old
        if [[ ! $curr = false ]]; then
          printf "We have: %s \n" "$curr"
        fi
        if [[ ! $old = false ]] ; then
          printf "We have: %s \n" "$old"
        fi
    done
  )

exit 0
