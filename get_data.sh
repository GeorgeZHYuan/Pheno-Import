#!/bin/bash

input=${"@"}

function get_patient_data {
	local patient_ids=("$@")
	local patients_found=()
	local patients_ommited=()
	local patient_dataset=()

	# Finds and stores patient JSON data array to patient_dataset
	echo -e "${LCYAN}Retrieving${NC} patient data..."
	for patient_id in "${patient_ids[@]}"; do
		echo -ne "requesting for patient $patient_id: "			
		data=$(curlToPheno "patients" $patient_id)		# curls content of phenotips address into 'data' variable
		if ! [[ "$data" =~ ^-?[0-9]+$ ]] ; then			# add to patient data array if valid data
	   		python extract_data.py $data 
			patient_dataset+=($data)
			patients_found+=($patient_id)
			echo -e "${LGREEN}Success${NC}"
		else											# add to ommited array if invalid data
			patients_ommited+=($patient_id)
			echo -e "${LRED}Failed${NC}"
		fi	
	done
	echo "${patient_dataset[@]}" > 'tmp/PATIENT_JSONS.tmp'

	# Stats for Patient data 
	amount_found=${#patients_found[@]}					
	amount_not_found=${#patients_ommited[@]}

	# Log results (loggit.sh)
	patientsLog $amount_found $amount_not_found "${patients_found[@]}" "${patients_ommited[@]}"
}
