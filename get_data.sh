#!/bin/bash

function getPatient {
	patient_id=$1
	url=$HOST:$PORT/rest/families/$patient_id

	local patient = $(curlToPheno url="$HOST:$PORT/rest/patients/$patient_id")
	echo $patient
}

function getFamily {
	family_id=$1
	url=$HOST:$PORT/rest/families/$family_id

	local family = $(curlToPheno $url)
	echo $family
}

function curlToPheno {
	url=$1
	args="-u $USER:$PSWD -X GET $url"

	status=$(curl -o -i -s -w "%{http_code}\n" $args)
	if [[ $status -eq 200 ]]; then
		response=$($request)
		echo $response
	else
		response=$status
		echo $status
	fi;

	loggit "$request" "$response"
}

function loggit {
	echo "Logging curl results to" $LOGFILE
    echo $(date '+%d/%m/%Y %H:%M:%S') >> $LOGFILE
    echo "Command:" $1 >> $LOGFILE
    echo $2 $'\r' $'\r' >> $LOGFILE
}
