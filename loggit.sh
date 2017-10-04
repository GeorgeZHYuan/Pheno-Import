#!/bin/bash

# Log curl command results
function curlLog {
	local request=$1
	local status=$2
	local response=$3
	local logfile_directories=("$CURL_LOGFILE" "$LOGFILE")
	
	for logfile_directory in "${logfile_directories[@]}"; do
		# log the date/time
    	echo $(date '+%d/%m/%Y %H:%M:%S') >> "$logfile_directory"
		
		# log the curl response
    	echo "Command:" $request $'\r' >> "$logfile_directory" 
		echo "Status:" $status $'\r' >> "$logfile_directory"
    	echo "Response:" $'\r' $response $'\r' >> "$logfile_directory"
		echo  $'\r' $'\r' $'\r' >> "$logfile_directory"
	done
}

# Log patient data retrieval results
function patientsLog {
	local logfile_directories=("$PATIENTS_LOGFILE" "$LOGFILE")
	local patients_found=$1
	local patients_not_found=$2
	local patient_ids=("${@:3}"); 

	for logfile_directory in "${logfile_directories[@]}"; do
		# log the date/time
		echo $(date '+%d/%m/%Y %H:%M:%S') >> "$logfile_directory"
		
		# log the patient data actually found
		echo "Success: Patients found ($patients_found)" $'\r' >> "$logfile_directory"
		for i in $(seq 1 $patients_found); do
			echo + $patient_id $'\r' >> "$logfile_directory"
		done

		# log the patient data not found
		echo $'\r'"Warning: Patients not found ($patients_not_found)" $'\r' >> "$logfile_directory"
		for i in $(seq 1 $patients_not_found); do
			echo - $patient_id $'\r' >> "$logfile_directory"
		done 

		# log summary
		echo $'\r'"Result: $patients_found/$patients_not_found patients added ("$(($patients_found * 100 / $patients_not_found))"%)" >> "$logfile_directory"
		echo $'\r' $'\r '$'\r' >> "$logfile_directory"
	done
}

export -f curlLog patientsLog
