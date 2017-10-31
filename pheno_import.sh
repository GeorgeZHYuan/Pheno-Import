#!/bin/bash

# Initialize variables
source $HOME/.Pheno_Settings.config
#upload_vars=("{$@:1:7}")
upload_vars=('usedefault' 'usedefault' 'usedefault' 'usedefault' 'usedefault' 'usedefault' 'usedefault')
$PH_HOME/src/initialize.sh "${upload_vars[@]}"

# Determine patients to upload
#patient_ids=("${@:8}")
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $TM_DATALOADER_PATH/tm_etl.jar -c $TM_CONFIG_FILE_PATH
