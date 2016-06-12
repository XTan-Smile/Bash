#!/bin/bash

########################################
# This script is for picking IRC files.
## --------------------------------------
# Author:                  Xiao Tan
# Email:                   xiao.tan@duke.edu
# Last Update:             May 15, 2016
########################################

if [ $# == 0 ]; then
    echo "Default search: current directory"
    inputDir=.
else
    inputDir=$1
fi
grep -ril '^\[..:..\] <.*>' 'inputDir' . --include=\*.txt > temp
sed 's/\ /\\ /g' temp > IRC_List
rm temp
echo "All IRC files are listed in IRC_List."
# END
