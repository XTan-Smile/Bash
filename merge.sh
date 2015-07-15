#!/bin/bash
####################################
# This file is to merge three files according to the UT number.
#     Input file:  conference_stage.txt
#                  conference_sponsor_uniq.txt
#                  conference_date.txt
#     Output file: conference.txt
#     FS == "\t"
# ----------------------------------
# Author:               Margaret Tan
# Email:       margaret.tan@duke.edu
# Last Update:         July 15, 2015
####################################

if [ $# == 0 ]; then
    echo "Please specify the input files."
    echo "The sequence of input files should be:"
    echo "    stage file"
    echo "    uniq sponsor file"
    echo "    date file"
fi
fileStage=$1;
fileSponsor=$2;
fileDate=$3;

## merge $fileSponsor and $fileStage into conferenceSS.txt
awk '
    BEGIN {FS = "\t"}
    NR==FNR { a[$1]=$2 }
    NR>FNR  { print $0, a[$1] }
' $fileSponsor $fileStage > conferenceSS.txt
## merge conferenceSS.txt and $fileDate int conference.txt
join -1 1 -2 1 conferenceSS.txt $fileDate > conference.txt
rm conferenceSS.txt

## How to output multi fields
# for(count=2;count<=NF;count++) print $count
