#!/bin/bash

function setup_clinical_file {
	local patient_ids=("$@")
	local patients_found=()
	local patients_ommited=()
	local patient_dataset=()

	# Finds and stores patient JSON data and create clinincal file
	echo -e "${LCYAN}Retrieving${NC} patient data..."
	for patient_id in "${patient_ids[@]}"; do
		echo -ne "requesting for patient $patient_id: "			
		data=$(curlToPheno "patients" $patient_id)		# curls content of phenotips address into 'data' variable
		#echo $data 
		if ! [[ "$data" =~ ^-?[0-9]+$ ]] ; then			# add to patient data array if valid data 
			echo -e "${LGREEN}Success${NC}" 		
			python extract_data.py "$data" 
			#echo $data
			echo -e "${LGREEN}Success${NC}"
			patient_dataset+=($data)
			patients_found+=($patient_id)
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
