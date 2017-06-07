#!/bin/bash
#
# Perform some operation to all the files in a directory
# shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY=$1

TMPOUT="outfile.txt"

ls -1 "$INCOMING_DIRECTORY" | while read FILE; do
      
       if [[ $FILE = "current_application_metadata" ]]; then
           printf "Inside initscripts: Current App meta: %s \n" "$FILE"
           CURR="current_application_metadata"
       fi 
       
       if [[ $FILE = "application_metadata" ]]; then
          printf "Inside initscripts: Application meta: %s \n" "$FILE"
          OLD="application_metadata"
       fi
    done
    
printf "\nCURR=$CURR\n OLD=$OLD\n TMPOUT=$TMPOUT\n"

        if [[ ! $CURR = false ]]; then
          printf "We have current_meta: %s \n" "current_application_metadata"
                if [[ ! $OLD = false ]]; then
                    printf "We have app_meta: %s \n" "application_metadata"
                        while read LINE; do
                          while read NEXT; do
                                      if [[ $LINE != $NEXT ]]; then
                                       echo "$NEXT" >> $TMPOUT
                                      fi
                           done < <(cat "current_application_metadata") 
                      done < <(cat "application_metadata") 
                else 
                   printf "No Application_Metadata!\n"
                fi
        else 
        printf "No Current_Metadata!\n";
        fi
sort $TMPOUT | uniq >> application_metadata       
exit 0
