#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
i=0
for patient_id in "${patient_ids[@]}"
do
	temp=$(curlToPheno "patients" $patient_id $'\r')
	if ! [[ "$temp" =~ ^-?[0-9]+$ ]] ; then
   		patient_dataset[$i]=$temp
		i+=1
	fi	
done

for data in "${patient_dataset[@]}"
do
	echo $data
done




