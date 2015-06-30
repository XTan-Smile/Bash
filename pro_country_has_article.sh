#!/bin/bash
########################################
# This script is for processing country_has_article.txt.
# Add corresponding ISO code at the end of each line.
#     Input file:   country_has_article.txt (paperid_country.txt)
#     Output file:  country_has_article_stage.txt
#     Added column: $3, $4, $5, showing the corresponding ISO codes
# --------------------------------------
# Author:                  Margaret Tan
# Email:                   margaret.tan@duke.edu
# Last Update:             June 30, 2015
#                          June 29, 2015
#########################################

echo Processing country ISO code......
## check the file for referencing ISO code exist
## if not, build one naming "ISO_ref.txt"
if [ $# == 0 ]; then
    echo "Input again..."
fi
inputFile=$1;
## check if file "ISO.txt" exists.
if [ -f "ISO.txt" ];
then
    echo "ISO.txt exists."
    isoFile=./ISO.txt
else
    # finding ISO.txt file
    echo "Finding ISO.txt..."
    find / -type f -name "ISO.txt" -print > temp
    isoFile=`head -1 temp`
    rm temp
fi
cat $isoFile | tr '[a-z]' '[A-Z]' > temp
# -----------------------------------
## count which countries have publiched papers
# awk 'BEGIN {FS = "\t"}
# { a[$2]++ }
# END {
#     for (i in a) print i" "a[i]
# }' $inputFile > exist_countries.txt
# -----------------------------------
echo Generating country_has_article_stage.txt file......
## if files do not exist or empty
if [ ! -f "ISO_sorted.txt" ]; then
    echo Sorting ISO file......
    sort -k 1 temp > ISO_sorted.txt
fi
rm temp
if [ ! -f "country_has_articvle_sorted.txt" ];then
    echo Sorting country_has_article file......
    sort -k 2 $inputFile > country_has_article_sorted.txt
fi
join -1 2 -2 1 country_has_article_sorted.txt ISO_sorted.txt > chas.txt
## switch the 1st and 2nd column of "country_has_artivle_stage.txt"
awk '{split($2, a, "\t"); sub(/[^:]+/,$1,$2);$1=a[1]}1' chas.txt > country_has_article_stage.txt
rm chas.txt
