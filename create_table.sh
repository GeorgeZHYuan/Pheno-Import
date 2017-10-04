#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
patient_dataset=()
patient_added=()
patient_ommited=()

for patient_id in "${patient_ids[@]}"
do
	temp=$(curlToPheno "patients" $patient_id)
	if ! [[ "$temp" =~ ^-?[0-9]+$ ]] ; then
   		patient_dataset+=($temp)
		patient_added+=($patient_id)
	else
		patient_ommited+=($patient_id)
	fi	
done

#echo "Patients found"
#for id in "${patient_added[@]}"
#do
#	echo $id
#done
#echo

#echo "Patients not found"
#for id in "${patient_ommited[@]}"
#do
#	echo $id
#done




