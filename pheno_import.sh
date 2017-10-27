#!/bin/bash

# Initialize variables
source conf/Pheno_Settings.config
src/initialize.sh $PH_HOME "$@"

# Determine patients to upload
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $TM_DATALOADER_PATH/tm_etl.jar -c $TM_CONFIG_FILE_PATH
