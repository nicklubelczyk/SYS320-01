#! /bin/bash

logFile="/var/log/apache2/access.log"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function displayOnlyPages(){
	# Extract the requested page (field 7) from the log file
	# Sort and count unique pages
	cat "$logFile" | cut -d '"' -f 2 | cut -d ' ' -f 2 | sort | uniq -c | sort -rn
}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors(){
	# Call histogram and filter results where visit count > 10
	histogram | while read -r count ip date;
	do
		if [[ $count -gt 10 ]]; then
			echo "$count $ip $date"
		fi
	done
}

function suspiciousVisitors(){
	# Check if ioc.txt exists
	if [[ ! -f "ioc.txt" ]]; then
		echo "Error: ioc.txt file not found. Please create it with indicators of attack."
		return 1
	fi
	
	# Read each indicator from ioc.txt and search for it in the log file
	# Display unique IP addresses that match any indicator
	echo "Suspicious IP addresses found:"
	while read -r indicator;
	do
		# Skip empty lines
		[[ -z "$indicator" ]] && continue
		grep -i "$indicator" "$logFile" 2>/dev/null
	done < ioc.txt | cut -d ' ' -f 1 | sort -u | uniq -c | sort -rn
}

# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	echo "[5] Frequent Visitors (more than 10 visits)"
	echo "[6] Suspicious Visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
		echo "Frequent Visitors (more than 10 visits per day):"
		frequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious Visitors:"
		suspiciousVisitors

	else
		echo "Invalid option. Please select a number between 1 and 7."
	fi
	
	echo ""
done
