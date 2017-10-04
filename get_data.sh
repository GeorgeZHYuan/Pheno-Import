#!/bin/bash

function getPatient {
	url="$HOST:$PORT/rest/patients/$1"
	local patient = $(curlPheno $url)
	echo $patient
}

function getFamily {
	url="$HOST:$PORT/rest/patients/$1"
	local family = $(curlPheno $url)
	echo $family
}

function curlToPheno {
	request="curl -u $USER:$PSWD -X GET $1"

	response=$($request)
#	echo $response

	status=$($request -I)
	echo $status
#	loggit "$request" "$response"
}

function loggit {
    echo $(date '+%d/%m/%Y %H:%M:%S') >> $LOGFILE
    echo "Command:" $1 >> $LOGFILE
    echo $2 $'\r' $'\r' >> $LOGFILE
}

