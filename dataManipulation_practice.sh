#!/bin/bash
########################################
# This script is for data manipulation, for verifying required conditions
# are satisfied.
#     DataSet under test: 7 columns, the 5th column are integers.
#     1. Show if there are any lines are not 7 columns.
#        If so, count and print these lines.
#     2. Show in those lines which are 7 columns but the 5th columns are
#        not digit.  If so, count and print these lines.
#     3. Verify that the values of the 1st columns are unique.
#        If not, return NO; If yes return YES.
#     4. Save the output into a log-file.
# --------------------------------------
# Author:                  Margaret Tan
# Last Update:             June 24, 2015
#########################################

############## Show if there are any lines are not 7 columns.############
## print out the first task
## if the script is called correctly
if [ $# == 0 ]; then
    echo "Input again..."
fi
inputFile=$1;
echo -----------------------------
echo  Showing if there are any lines are not 7 columns......
## NF: the # of fields variable
## NR: the ordinal # of the current record from the start of input.
# get into awk
awk '
BEGIN {count=0}
{
    if (NF!=7){
        count+=1;
        print "The ", NR, "- line has ", NF, "fields.";
    }
}
END {
    if (count!=0)
        print "The file has ", count, " line(s) which do not have 7 columns.";
    else
        print "The file has past the test 1: no lines are not 7 columns.";
}' $inputFile;

############ Show in those lines the 5th columns are not digit.##########
echo -----------------------------
echo Showing in those lines the 5th columns are not digit......
## FS - the input field separator variable, here is '\t'
## NR - the ordinal # of the current record from the start of input
## FNR - the ordinal # of the corrent record in the current file
# get into awk
awk '
BEGIN { FS = "\t"; count=0 }
    $5 !~ /^[0-9]*$/ {
         count+=1;
         print "The line ", NR, ": ", $5, "is not a digit";
    }
END {
    print "There are ", count, " line(s) whose 5th columns are not digit.";
}' $inputFile;

######### Verify that the values of the 1st columns are unique.##########
echo -----------------------------
echo Verifying if the values of the 1st columns are unique......
awk '
    NR==FNR {a[$1]++}
    NR>FNR && a[$1]>1
' $inputFile $inputFile
echo -----------------------------
## test if exit successfully
if [ $? = 0 ]; then
    echo "TEST SUCCESSFUL"
else
    echo "TEST FAILED"
fi

################### Save the output into a log-file.#####################
#ISI=/Users/mtan/Documents/shellP;
#sh $ISI/dataMani.sh input $ISI > $ISI/logFile.log 2>$1
#sh dataMani.sh > logFile.log