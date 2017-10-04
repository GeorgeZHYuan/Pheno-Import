#!/bin/bash

# Get JSON data from phenotips from curl command
function curlToPheno {
	local url=$HOST:$PORT/rest/$1/$2
	local args="-u $USER:$PSWD -X GET $url"
	local request="curl -s $args"

	# get response headers
	status=$(curl -o .temp -s -w "%{http_code}\n" $args); rm .temp
	
	# check if response is successful
	if [[ $status -eq 200 ]]; then 	
		response=$($request)			# response set to JSON data on success
	else
		response=$status				# response set to error code on failure
	fi;

	# return response as an echo
	echo $response

	# log curl results
	curlLog "$request" "$status" "$($request)"
}
