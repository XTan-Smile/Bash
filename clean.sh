#!/bin/bash
########################################
# This script is for removing all temporary files in current directory.
#     Input file:   NONE
#     Output file:  NONE
# --------------------------------------
# Author:                  Margaret Tan
# Email:                   margaret.tan@duke.edu
# Last Update:             June 30, 2015
# Special command:         NONE
# Environmental Variables: NONE
#########################################

## find temporary files
find . -type f -name "*~" -print > temp
## check if "temp" is NOT empty
if [ -s temp ];then
    rm `cat temp`
fi
rm temp
# ------------
find . -type f -name "\#*" -print > temp
if [ -s temp ];then
    rm `cat temp`
fi
rm temp
