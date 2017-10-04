#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
patient_dataset=()
patients_found=()
patients_ommited=()

for patient_id in "${patient_ids[@]}"; do
	temp=$(curlToPheno "patients" $patient_id)
	if ! [[ "$temp" =~ ^-?[0-9]+$ ]] ; then
   		patient_dataset+=($temp)
		patients_found+=($patient_id)
	else
		patients_ommited+=($patient_id)
	fi	
done

amount_found=${#patients_found[@]}
amount_not_found=${#patients_ommited[@]}

patientsLog $amount_found $amount_not_found "${patients_found[@]}" "${patients_ommited[@]}"
