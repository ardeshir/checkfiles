#!/bin/bash
# report.bash: simple report formatter
#

# The report is read from DATA_FILE.  It should contain
# the following columns:
#
#   Column 1: PRODUCT = Product name
#   Column 2: CSALES  = Country Sales
#   Column 3: FSALES  = Foreign Sales
#
# The script will format the data into columns, adding total and
# average sales per item as well as a item count at the end of the
# report.

# Some Linux systems use USER instead of LOGNAME

if [ -z "$LOGNAME" ] ; then           # No login name?
   declare –rx LOGNAME="$USER"        # probably in USER
fi

shopt -s -o nounset

# Global Declarations

declare -rx SCRIPT=${0##*/}           # SCRIPT is the name of this script
declare -rx DATA_FILE="current_application_metadata"    # this is data for the report
declare -i  ITEMS=0                   # number of report items
declare -i  LINE_TOTAL=0              # line totals
declare -i  LINE_AVG=0                # line average
declare     PRODUCT                   # product name from data file
declare -i  CSALES                    # country sales from data file
declare -i  FSALES                    # foreign sales from data file
declare -rx REPORT_NAME="Sales Report" # report title
# Sanity Checks

if test ! -r "$DATA_FILE" ; then
   printf "$SCRIPT: the report file is missing—aborting\n" >&2
   exit 192
fi

# Generate the report

printf "Report created on %s by %s\n" "`date`" "$LOGNAME"
printf "\n"
printf "%s\n" "$REPORT_NAME"
printf "\n"
printf "%-12s%12s%12s%12s%12s\n" "Product" "Country" "Foreign" "Total" "Average"
printf "%-12s%12s%12s%12s%12s\n" "——" "——" "——" "——" "——"

{ while read PRODUCT CSALES FSALES ; do
   let "ITEMS+=1"
   LINE_TOTAL="CSALES+FSALES"
   LINE_AVG="(CSALES+FSALES)/2"
   printf "%-12s%12d%12d%12d%12d\n" "$PRODUCT" "$CSALES" "$FSALES" \
"$LINE_TOTAL" "$LINE_AVG"
done } < $DATA_FILE

# Print report trailer

printf "%-12s%12s%12s%12s%12s\n" "——" "——" "——" "——" "——"
printf "Total number of products: %d\n" "$ITEMS"
printf "\n"
printf "End of report\n"

exit 0
