#!/bin/bash

. ./curl_request.sh 

function get_patient_data {
	local patient_ids=("$@")
	local patients_found=()
	local patients_ommited=()
	local patient_dataset=()

	# Finds and stores patient JSON data array to patient_dataset
	for patient_id in "${patient_ids[@]}"; do			
		data=$(curlToPheno "patients" $patient_id)		
		if ! [[ "$data" =~ ^-?[0-9]+$ ]] ; then			# add to patient data array if valid data
	   		patient_dataset+=("$data")
			patients_found+=($patient_id)
		else											# add to ommited array if invalid data
			patients_ommited+=($patient_id)
		fi	
	done

	# Stats for Patient data 
	amount_found=${#patients_found[@]}					
	amount_not_found=${#patients_ommited[@]}
	
	# Log results (loggit.sh)
	patientsLog $amount_found $amount_not_found "${patients_found[@]}" "${patients_ommited[@]}"

	# remove spaces
	for i in $(seq 0 $((${#patient_dataset[@]} - 1))); do
		patient_dataset[$i]=$(echo ${patient_dataset[$i]} | tr -d ' ')
	done

	echo "${patient_dataset[@]}"
}

