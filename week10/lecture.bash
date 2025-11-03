#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"


function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function pageCount(){
pages=$(cat "$file" | grep "GET" | cut -d'"' -f2 | cut -d' ' -f2 |
sort | uniq -c | sort -rn)
}

getAllLogs
pageCount
echo "$pages"
