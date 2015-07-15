#!/bin/bash
####################################
# This file is to merge those lines with the same UT number, and 
# add separate sponsors with a comma.
#     Input file:     conference_sponsor.txt
#     Output file:    conference_sponsor_uniq.txt
# Note: the input file conference_sponsor.txt should be formerly
# sorted according to the 1st field.
# ----------------------------------
# Author:               Margaret Tan
# Email:       margaret.tan@duke.edu
# Last Update:         July 15, 2015
####################################

if [ $# == 0 ]; then
    echo "Please specify the input files."
    echo "The sequence of input files should be:"
    echo "    conference_sponsor.txt"
fi
fileSponsor=$1;
## estimate how many duplicated lines w.r.t the 1st column of $fileSponsor
awk '{print $1}' $fileSponsor | uniq -c | awk '{print $1}' > duplicateLines.txt
## merge rows with the same UT number
awk 'BEGIN { FS = "\t"; count=0 }
    NR>FNR {
        if (FNR == 1) count=1
        if (FNR%a[count]==0){
            print $0
            count+=1
        } 
        else if (FNR%a[count]+1 == a[count]) {
            printf "; %s:", $2
        }
        else {
            printf "; %s", $2
        }
    }
    NR==FNR {
        count+=1;
        a[count]=$1
    }
' duplicateLines.txt $fileSponsor > temp
rm duplicateLines.txt
## switch the 1st and 2nd column of the output
awk 'BEGIN{ FS = ":" } {
    split($2, a, ":");
    sub(/[^:]+/,$1,$2);
    $1=a[1]
}1' temp > conference_sponsor_uniq.txt
rm temp
