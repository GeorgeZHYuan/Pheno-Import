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
	curlLog "$request" "$status" "$($request)" "$CURL_LOGFILE"
	curlLog "$request" "$status" "$($request)" "$LOGFILE"
}

function curlLog {
	local request=$1
	local status=$2
	local response=$3
	local log_directory=$4

    echo $(date '+%d/%m/%Y %H:%M:%S') >> "$log_directory"
    echo "Command:" $request $'\r' >> "$log_directory" 
	echo "Status:" $status $'\r' >> "$log_directory"
    echo "Response:" $'\r' $response $'\r' >> "$log_directory"
	echo  $'\r' $'\r' $'\r' >> "$log_directory"
}


