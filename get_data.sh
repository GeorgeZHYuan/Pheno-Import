#!/bin/bash

function curlToPheno {
	url=$HOST:$PORT/rest/$1/$2
	args="-u $USER:$PSWD -X GET $url"

	request="curl -s $args"
	status=$(curl -o .temp -s -w "%{http_code}\n" $args)
	
	if [[ $status -eq 200 ]]; then	
		response=$($request)
	else
		response=$status
	fi;

	if [ -e .temp ]; then 
		rm .temp
	fi;
	
	echo $response
	curlLog "$request" "$status" "$($request)"
}

function curlLog {
	local request=$1
	local status=$2
	local response=$3
	local logfiles=("$CURL_LOGFILE" "$LOGFILE")
	
	for logfile in "${logfiles[@]}"; do
    	echo $(date '+%d/%m/%Y %H:%M:%S') >> "$logfile"
    	echo "Command:" $request $'\r' >> "$logfile" 
		echo "Status:" $status $'\r' >> "$logfile"
    	echo "Response:" $'\r' $response $'\r' >> "$logfile"
		echo  $'\r' $'\r' $'\r' >> "$logfile"
	done
}


