#!/bin/bash
#
# Perform some operation to all the files in a directory
# shopt -s -o nounset

declare -rx SCRIPT=${0##*/}
declare -rx INCOMING_DIRECTORY=$1
declare DIR="initscripts"

OUTFILE=
INFILE=

process_data() {
ONE=$1
TWO=$2
THREE=$3
FOUR=$4

echo $ONE $TWO $THREE $FOUR 

}

parse_records() {
>$OUTFILE
exec 4<&1
exec 1> $OUTFILE 
while read RECORD
do 
    echo $RECORD | awk -F , '{print \
    $1 , $2 , $3 , $4}' \
     | while read ONE TWO THREE FOUR
        do 
           # perform stuff 
            process_data $ONE $TWO $THREE
          if (( $? != 0 )); then
           echo "Record ERROR" | tee -a $LOG
          fi
        done
done < $INFILE
# clean up
exec 1<&4
exec 4>&- 
}


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
