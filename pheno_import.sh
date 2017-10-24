#!/bin/bash

# Initialize
source conf/vars

# Determine upload instructions
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
python src/setup_data_file.py "${patient_ids[@]}"

## Upload to transmart
#echo -e "${LCYAN}Uploading${NC} data to transmart"
#./upload_data.sh
