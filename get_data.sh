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
