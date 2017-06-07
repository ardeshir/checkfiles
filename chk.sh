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
    
#printf "We're out of main while\n"
printf "\nCURR=$CURR\n OLD=$OLD\n TMPOUT=$TMPOUT\n"

        if [[ ! $CURR = false ]]; then
          printf "We have current_meta: %s \n" "current_application_metadata"
                if [[ ! $OLD = false ]]; then
                    printf "We have app_meta: %s \n" "application_metadata"
                        while read LINE; do
                          while read NEXT; do
                                if grep $NEXT $TMPOUT ; then
                                  break 
                                else 
                                      if [[ $LINE != $NEXT ]]; then
                                       echo "$NEXT" >> $TMPOUT
                                      fi
                                 fi
                           
                           done < <(cat "current_application_metadata") 
                      done < <(cat "application_metadata") 
                else 
                   printf "2- Else: $OLD\n"
                fi
        else 
        printf "1- Else: $CURR\n"
        fi
sort $TMPOUT | uniq >> application_metadata       
exit 0
