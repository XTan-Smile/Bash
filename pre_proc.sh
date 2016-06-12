#!/bin/bash
path=.
for file_name in IRC_List; do
    sed -e "s/^O//" $file_name > temp
    mv temp $file_name
done

#END
