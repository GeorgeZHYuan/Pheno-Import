#!/bin/bash

. ./get-data.sh

patient_ids = $1
for patient_id in "${patient_ids[@]}"
do
	local patient = $(getPatient $patient_id)
	addPatient $patient
done

function addPatient {
	echo "Oooooohohohoho"
}
