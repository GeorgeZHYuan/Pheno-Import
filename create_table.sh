#!/bin/bash

. ./get_data.sh 

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






