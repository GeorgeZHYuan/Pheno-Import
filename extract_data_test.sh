#!/bin/bash

#Assume data file has all required column labels, data will be appended to it

#Software jq needs to be downloaded
#sudo apt-get install jq

declare -a arr=(".report_id" ".external_id" ".patient_name.first_name" ".patient_name.last_name" ".sex" ".life_status" ".date_of_birth.year" ".date_of_birth.month" ".date_of_birth.day" ".date_of_death.year" ".date_of_death.month" ".date_of_death.day" ".ethnicity.maternal_ethnicity[0]" ".ethnicity.paternal_ethnicity[0]")

subjID=1
data_JSON=("$@")

#Do a for loop to add the data by iteration
#for data in "${data_JSON[@]}"; do
	patient_data=()
	patient_data+=$subjID"	"
	for label in "${arr[@]}"; do
		#res=$(echo $data | jq  -r $label )
		test=$(jq '.ethnicity.maternal_ethnicity | type' sample_data.txt)
		res=$(jq -r $label $data_JSON)
		if ! [[ "$res" == null ]]; then
			patient_data+=$res
		fi;
		patient_data+="	"
	done
	echo "${patient_data[@]}" >> extracted_data.txt
	subjID=$(( $subjID + 1 ))
#done

if ["$test" == "array"]; then 
	echo $test
fi;

#How to check if string matches, make if statement work properly
