#!/bin/bash

. ./get_data.sh 

patient_ids=("$@")
i=0
for patient_id in "${patient_ids[@]}"
do
	patient_dataset[$i]=$(curlToPheno "patients" $patient_id $'\r') >> testfile.txt
	i+=1
done

for data in "${patient_dataset[@]}"
do
	echo $data
done




