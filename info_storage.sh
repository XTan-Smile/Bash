#!/bin/bash

########################################
# This script is for generating file usrName.
# Four columns in usrName:
# conversation ID, conversation start time, user name, content.
# field delimiter: #
## --------------------------------------
# Author:                  Xiao Tan
# Email:                   xiao.tan@duke.edu
# Last Update:             May 23, 2016
########################################

LANG=C
IFS=$'\n' 

while read file_name; do
    session_start=''
    bracket=$(echo $line | cut -d "[" -f2 | cut -d "]" -f1)
    tab='#'
    while read line; do
	user=''
	content=''
	if echo "$line" | grep 'Session Start:'; then
	    echo "$line" | grep 'Session Start: ' | cut -d ":" -f 2,3,4 >> timeStart
	    session_start=$(echo "$line" | grep 'Session Start: ' | cut -d ":" -f 2,3,4)
	elif echo "$line" | grep 'Session Time: '; then
	    echo "$line" | grep 'Session Time: '  | cut -d ":" -f 2,3,4 >> timeFailSession
	elif echo "$line" | grep 'Session Ident: '; then
	    echo "$line" | grep 'Session Ident: ' | cut -d ":" -f 2,3,4 >> conversationID
	elif echo "$bracket"; then
	    if [[ "$line" =~ "<" && "$line" =~ ">" ]]; then
		user=$(echo $line | cut -d "<" -f2 | cut -d ">" -f1)
		content=$(echo $line | cut -d ">" -f2)
		echo $session_start$tab$user$tab$content >> usrName
	    fi
	fi
    done < $file_name
#    grep 'Session Start: ' $file_name >> time_start
#    grep 'Session Close: ' $file_name >> time_close
#    grep 'Session Time: ' $file_name >> time_fail_session
#    grep 'Session Ident: ' $file_name >> conversation_ID
#    rm conversation_t
done < IRC_List
# sort usrName | uniq -u
awk '{printf "%d\t%s\n", NR, $0}' < conversationID > temp
awk '{print $0"#"}' temp > cID
awk '{printf "%d\t%s\n", NR, $0}' < timeStart > tStart
join cID tStart | column -t > temp
awk 'BEGIN{ FS="#" }{print $0"#"}' temp > conversation
rm temp

## sort two files, prepare to merge
## remove the first column, sort conversation, pick uniq start time
cut -d "#" -f 2- conversation | sort -i -k 2 -b -s -t "#" | uniq > temp
rm conversation
mv temp conversation
## sort and uniq usrName
#sort -i -k 1 -b -s -t "#" usrName
### count duplicate lines in usrName
echo " end#" >> usrName
awk '
BEGIN { FS = "#" }
{
    # Keep count of the fields in first column
    count[$1]++;
    if (count[$1] == 1) {
        print c;
        c = 1;
    }
    if (count[$1] >= 2)
        c++;
}' usrName > temp
### set repeat time for each line
sed '1d' temp > repeatTime
paste -d "#" repeatTime conversation > temp
rm repeatTime
awk '
BEGIN { FS = "#" }
{
    for (i=0; i<$1; i++) {
        print $0;
    }
}' temp | cut -d "#" -f 2- > conversation
cut -d "#" -f 2- usrName > temp
### merge
paste conversation temp > usrName
rm temp conversation
# END
