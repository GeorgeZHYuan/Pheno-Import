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
	loggit "$request" "$response"
}

function loggit {
    echo $(date '+%d/%m/%Y %H:%M:%S') >> $LOGFILE
    echo "Command:" $1 >> $LOGFILE
    echo $2 $'\r' $'\r' >> $LOGFILE
}


