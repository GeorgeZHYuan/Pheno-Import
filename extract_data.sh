#!/bin/bash

#Assume data file has all required column labels, data will be appended to it

#Software jq needs to be downloaded
#sudo apt-get install jq

declare -a arr=(".report_id" ".external_id" ".patient_name.first_name" ".patient_name.last_name" ".sex" ".life_status" ".date_of_birth.year" ".date_of_birth.month" ".date_of_birth.day" ".date_of_death.year" ".date_of_death.month" ".date_of_death.day")

subjID=1
data_JSON=("$@")

if [ -e $DATA_UPLOAD_FILE ]; then
	rm $DATA_UPLOAD_FILE
fi;
cp $TABLE_TEMPLATE $DATA_UPLOAD_FILE

#Do a for loop to add the data by iteration
for data in "${data_JSON[@]}"; do
	patient_data=()
	patient_data+=$subjID"	"
	for label in "${arr[@]}"; do
		res=$(echo $data | jq  -r $label )
		if ! [[ "$res" == null ]]; then
			patient_data+=$res
		fi;
		patient_data+="	"
	done
	echo "${patient_data[@]}" >> $DATA_UPLOAD_FILE
	subjID=$(( $subjID + 1 ))
done


