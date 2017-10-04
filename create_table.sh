#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
for patient_id in "${patient_ids[@]}"
do
	local patient=$(getPatient $patient_id)
	addPatient $patient
	echo "test"
done

function addPatient {
	echo "Oooooohohohoho"
}


