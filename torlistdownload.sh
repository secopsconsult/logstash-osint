#!/bin/bash

###############################
# Script to Download Tor data #
# from dan.me.uk - DO NOT RUN #
# more than once per 30 mins  #
###############################

TMP="/tmp"
PATH2="/etc/logstash/support"

/usr/bin/wget "https://www.dan.me.uk/tornodes" -O $TMP/tornodes.txt
if [ $? -eq 0 ]; then
        // Prep file
        LEN=$(wc -l $TMP/tornodes.txt | awk '{print $1}')
        END=$(grep -n "<\!-- __END_TOR_NODE_LIST__ //-->" $TMP/tornodes.txt | cut -d: -f1)
        END=$(expr $END - 1)

        mv $PATH2/tornodes.txt $PATH2/tornodes.txt.old
        cat $TMP/tornodes.txt | head -n $END | cut -d\| -f1 | awk '{print $1 ":true"}' > $PATH2/tornodes.txt
fi
