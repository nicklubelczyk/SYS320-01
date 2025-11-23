#!/bin/bash

data=$(curl -s http://10.0.17.47/Assignment.html | \
sed -n 's/.*<td>\([^<]*\)<\/td>.*/\1/p')

total=$(echo "$data" | wc -l)
half=$((total / 2))
rows=$((half / 2))

temps=$(echo "$data" | sed -n "1~2p;${half}q")
dates=$(echo "$data" | sed -n "2~2p;${half}q")
press=$(echo "$data" | sed -n "$((half + 1)),${total}p" | sed -n "1~2p")

for i in $(seq 1 $rows); do
    tempfinal=$(echo "$temps" | sed -n "${i}p")
    pressfinal=$(echo "$press" | sed -n "${i}p")
    datefinal=$(echo "$dates" | sed -n "${i}p")
    echo "$pressfinal $tempfinal $datefinal"
done
