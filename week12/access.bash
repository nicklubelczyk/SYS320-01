#!/bin/bash



date '+%a %b %d %I-%M-%S %p' >> fileaccesslog.txt

echo "To: nickolas.lubelczyk@mymail.champlain.edu" > finalemail.txt
echo "Subject: File Access" >> finalemail.txt
cat fileaccesslog.txt >> finalemail.txt
cat finalemail.txt | ssmtp nickolas.lubelczyk@mymail.champlain.edu
