#!/bin/bash
#
# subshell.sh
#
# Perform some operation to all the files in a directory

shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY="."

ls -1 "$INCOMING_DIRECTORY" |
  (
    while read FILE ; do
       printf "$SCRIPT: Processing %s...\n" "$FILE"
       # <-- do something here
       if [[ $FILE = "current_application_metadata" ]]; then
           printf "Current App meta: %s \n" "$FILE"
       fi
       if [[ $FILE = "application_metadata" ]]; then
          printf "Application meta: %s \n" "$FILE"
       fi
    done
  )
printf "Done\n"
exit 0
