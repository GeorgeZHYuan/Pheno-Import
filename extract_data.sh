#!/bin/bash

#Assume data file has all required column labels, data will be appended to it

#Software jq needs to be downloaded
#sudo apt-get install jq

declare -a arr=(".report_id" ".external_id" ".patient_name.first_name" ".patient_name.last_name" ".sex" ".life_status" ".date_of_birth.year" ".date_of_birth.month" ".date_of_birth.day" ".date_of_death.year" ".date_of_death.month" ".date_of_death.day")

data_JSON=("$@")

patient_data=()

a=1
#data=0

#Do a for loop to add the data by iteration
for data in "${data_JSON[@]}"; do
	patient_data+=$a
	patient_data+="	"
	for label in "${arr[@]}"; do
		patient_data+=$(jq -r $label $data)
		patient_data+="	"
	done
	a=$(( $a + 1 ))
done

echo "${patient_data[@]}" >> extracted_data.txt
