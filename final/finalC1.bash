#!/bin/bash

curl -s http://10.0.17.47/IOC.html | grep '<td>' | \
sed 's/.*<td>\(.*\)<\/td>.*/\1/' | awk 'NR % 2 == 1' > IOC.txt
