
#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
 logline=$(cat "$authfile" | grep "authentication failure")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,16 | tr -d '\.' | sed 's/user=//')
 echo "$dateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: nickolas.lubelczyk@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp nickolas.lubelczyk@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 

echo "To: nickolas.lubelczyk@mymail.champlain.edu" > failedemailform.txt
echo "Subject: Failed Logins" >> failedemailform.txt
getFailedLogins >> failedemailform.txt
cat failedemailform.txt | ssmtp nickolas.lubelczyk@mymail.champlain.edu
