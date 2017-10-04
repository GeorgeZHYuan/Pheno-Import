#!/bin/bash

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

function patientsLog {
	local logfiles=("$PATIENTS_LOGFILE" "$LOGFILE")
	local patients_found=$1
	local patients_not_found=$2
	local patient_ids=("${@:3}"); 

	for logfile in "${logfiles[@]}"; do
		echo $(date '+%d/%m/%Y %H:%M:%S') >> "$logfile"
		n=0 

		echo "Success: Patients found ($patients_found)" $'\r' >> "$logfile"
		for i in $(seq 1 $patients_found); do
			echo + $patient_id $'\r' >> "$logfile"
		done

		echo $'\r'"Warning: Patients not found ($patients_not_found)" $'\r' >> "$logfile"
		for i in $(seq 1 $patients_not_found); do
			echo - $patient_id $'\r' >> "$logfile"
		done 
		echo $'\r'"Result: $patients_found/$patients_not_found patients added ("$(($patients_found * 100 / $patients_not_found))"%)" >> "$logfile"
		echo $'\r' $'\r '$'\r' >> "$logfile"
	done
	
}

export -f curlLog patientsLog
