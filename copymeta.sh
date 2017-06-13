#!/bin/bash

declare DIR="/ltapps/initscripts"

copy_current_uniq() {
cat "current_application_metadata"    |  uniq >> "$DIR/application_metadata_t"
sort -u "$DIR/application_metadata_t" |  uniq >  "$DIR/application_metadata" 
}

if [[ -d "$DIR" && -x "$DIR" ]]; then 
printf "Initscrtipt directory exists...\n" 
     if [[ -f "$DIR/application_metadata" ]]; then
       printf "Old $DIR/application_metadata exists...\n"
       copy_current_uniq
     else 
     printf "Coping current to application_metadata"
     cp "current_application_metadata" "$DIR/application_metadata"
     # exit 0
     fi
else
 echo "Creating directory\n"
 echo "Coping application_metadata\n" 
 mkdir "$DIR"
 copy_current_uniq
 # exit 0
fi

# clean up
rm "$DIR/application_metadata_t" 
exit 0
