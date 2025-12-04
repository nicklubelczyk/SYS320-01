#!/bin/bash

echo "<html>" > report.html
echo "<body>" >> report.html
echo "Access logs with IOC indicators:" >> report.html
echo "<table border='1'>" >> report.html

while read line; do
    echo "<tr>" >> report.html
    echo "$line" | awk '{print "<td>" $1 "</td><td>" $2 "</td><td>" $3 "</td>"}' >> report.html
    echo "</tr>" >> report.html
done < report.txt

echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

mv report.html /var/www/html/
