#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
patient_dataset=()
patients_found=()
patients_ommited=()

# Finds and stores patient JSON data array to patient_dataset
for patient_id in "${patient_ids[@]}"; do			
	data=$(curlToPheno "patients" $patient_id)		
	if ! [[ "$data" =~ ^-?[0-9]+$ ]] ; then			# add to patient data array if valid data
		#echo $data
   		patient_dataset+=("$data")
		patients_found+=($patient_id)
	else											# add to ommited array if invalid data
		patients_ommited+=($patient_id)
	fi	
done

# Stats for Patient data 
amount_found=${#patients_found[@]}					
amount_not_found=${#patients_ommited[@]}

./create_new_study_clinical_file.sh "${patient_dataset[@]}"

# Log results (loggit.sh)
patientsLog $amount_found $amount_not_found "${patients_found[@]}" "${patients_ommited[@]}"
