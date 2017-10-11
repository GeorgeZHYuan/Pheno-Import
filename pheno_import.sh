#!/bin/bash

# Initialize
source conf/vars
source logs/loggit.sh

. ./get_data.sh
. ./curl_request.sh 



import_method="existing"
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
patient_dataset=($(get_patient_data "${patient_ids[@]}"))

# Create tables for upload
if [[ $import_method == "new" ]]; then
	echo "Creating tables for new study import"
	./create_new_study_clinical_file.sh "${patient_dataset[@]}"
	
elif [[ $import_method == "existing" ]]; then
	echo "Creating tables for existing study import"
	./create_tables_existing_study.sh "${patient_dataset[@]}"

else
	echo "Error: Invalid upload method."
	echo "Warning: Please make sure the import_method variable is set correctly."

fi;

## Upload to transmart
#./upload_data.sh
