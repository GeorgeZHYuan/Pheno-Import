#!/bin/bash

# Initialize
source conf/*

. ./logs/loggit.sh
. ./get_data.sh
. ./curl_request.sh 

# Determine upload instructions
import_method="new"
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
get_patient_data "${patient_ids[@]}"
patient_dataset=($(<'tmp/PATIENT_JSONS.tmp'))

# Create tables for upload
if [[ $import_method == "new" ]]; then
	echo "Creating tables for new study import"
	./create_new_study_clinical_file.sh "${patient_dataset[@]}"
	
elif [[ $import_method == "existing" ]]; then
	echo -e "${LCYAN}Creating${NC} tables for existing study import:..."
	./create_tables_existing_study.sh "${patient_dataset[@]}"

else
	echo "Error: Invalid upload method."
	echo "Warning: Please make sure the import_method variable is set correctly."

fi;

# Upload to transmart
echo -e "${LCYAN}Uploading${NC} data to transmart"
./upload_data.sh
