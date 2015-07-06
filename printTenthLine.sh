#!bin/bash
#################################
# This file is just for practice:
#     Read from the file file.txt and output the 10th line to stdout.
# -------------------------------
# Author:       Margaret Tan
# Last Update:  July 6, 2015
#################################

### count the # of lines in file.txt
lines=`awk 'END{print NR}' file.txt`
# or: lines=`sed -n '$=' file.txt`
# or: lines=`cat file.txt | wc -l`
if [ $lines -gt 9 ]; then
### output the 10th line
    cat file.txt | tail -n +10 | head -n 1
    # or: cat file.txt | head -n 10 | tail -n +10
    # or: sed -n '10,10p' file.txt
fi
