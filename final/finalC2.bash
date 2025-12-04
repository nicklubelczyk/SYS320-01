#!/bin/bash

logfile=$1
iocfile=$2

> report.txt
while read ioc; do
    grep "$ioc" "$logfile" | awk '{print $1, $4, $7}' | \
sed 's/\[//g; s/\]//g' >> report.txt
done < "$iocfile"
