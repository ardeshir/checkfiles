#!/bin/bash
#
# Perform some operation to all the files in a directory
# shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY=$1
declare CURR
declare OLD
declare DIR="initscripts"
TMPOUT="outfile.txt"
LOG="logfile.txt"

if [[ -d "$DIR" && -x "$DIR" ]]; then 
printf "Initscrtipt exists...\n" 
     if [[ -f "$DIR/application_metadata" ]]; then
       printf "Old $DIR/application_metadata exitst...\n"
       OLD=true
     else 
     printf "Coping current to application_metadata"
     fi
else
 echo "Creating directory\n"
 echo "Coping application_metadata\n" 
fi

printf "We have current_meta: %s \n" "current_application_metadata" >> $LOG
                if [[ $OLD = true ]]; then
                printf "We have app_meta: %s \n" "application_metadata" >> $LOG
                        while read LINE; do
                          while read NEXT; do

                                      if [[ $LINE != $NEXT ]]; then
                                       echo "$NEXT" >> $TMPOUT
                                      fi
                                      
                           done < <(cat "current_application_metadata") 
                           
                      done < <(cat "$DIR/application_metadata") 
                else 
                printf "No Application_Metadata, using current!\n" >> $LOG
                fi

sort -u $TMPOUT | uniq >> "$DIR/application_metadata" 

# clean up
# rm outfile.txt 
# rm logfile.txt
exit 0
