#!/bin/bash

# Initialize
source conf/vars
source conf/colors

. ./logs/loggit.sh
. ./get_data.sh
. ./curl_request.sh 

# Determine upload instructions
import_method="new"
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
setup_clinical_file "${patient_ids[@]}"

# Create tables for upload
if [[ $import_method == "existing" ]]; then
	echo -e "${LCYAN}Adjusting${NC} to existing study :..."
	#./create_tables_existing_study.sh "${patient_dataset[@]}"
fi;

# Upload to transmart
echo -e "${LCYAN}Uploading${NC} data to transmart"
./upload_data.sh
