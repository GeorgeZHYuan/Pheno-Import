#!/bin/bash

#Assume data file has all required column labels, data will be appended to it

#Software jq needs to be downloaded
#sudo apt-get install jq

declare -a arr=(".report_id" ".external_id" ".patient_name.first_name" ".patient_name.last_name" ".sex" ".life_status" ".date_of_birth.year" ".date_of_birth.month" ".date_of_birth.day" ".date_of_death.year" ".date_of_death.month" ".date_of_death.day")

data_JSON=("$@")

patient_data=()

a=1

#Do a for loop to add the data by iteration

patient_data+=$a
patient_data+="	"
patient_data+=$(jq -r ${arr[0]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[1]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[2]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[3]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[4]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[5]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[6]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[7]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[8]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[9]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[10]} ${data_JSON[$i]})
patient_data+="	"
patient_data+=$(jq -r ${arr[11]} ${data_JSON[$i]})
patient_data+="	"

a=$(( $a + 1 ))

echo "${patient_data[@]}" >> extracted_data.txt
