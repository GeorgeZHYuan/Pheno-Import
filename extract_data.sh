#!/bin/bash

#Assume data file has all required column labels, data will be append to it

#Software jq needs to be downloaded
#sudo apt-get install jq

data_JSON=("$@")

#printf "\n" >> extracted_data.txt

patient_data=()
#echo -e "$a\t" >> extracted_data.txt

#a=$(( $a + 1 ))

#Do a for loop to add the data by iteration
#patient_data+=$(jq -r '.report_id' ${data_JSON[$i]})

patient_data+=$(jq -r '.report_id' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.external_id' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.patient_name .first_name' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.patient_name .last_name' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.sex' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.life_status' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.date_of_birth .year' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.date_of_birth .month' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.date_of_birth .day' sample_data.JSON)
patient_data+="	"
patient_data+=$(jq -r '.death_date .day' sample_data.JSON)
patient_data+="	"

#jq -r '.patient_name .last_name'  sample_data.JSON >> extracted_data.txt

echo "${patient_data[@]}" >> extracted_data.txt

#echo -e "\t" >> extracted_data.txt
