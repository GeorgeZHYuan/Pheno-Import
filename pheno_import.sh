#!/bin/bash

# Initialize variables
source $HOME/.Pheno_Settings.config

# TOP NODE \ Study Name \ Study ID \ Phenotips Address \ Phenotips Username \ Phenotips Password
#upload_vars=("{$@:1:6}") 
upload_vars=('Public Studies' 'Phenotips' 'PHENOTEST' 'localhost:10000' 'Admin' 'admin')

$PH_HOME/initialize.sh "${upload_vars[@]}"

# Determine patients to upload
#patient_ids=("${@:7}")
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004' 'P0000005' 'P0000006')

# Get the patient data from phenotips
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $TM_DATALOADER_PATH/tm_etl.jar -c $TM_CONFIG_FILE_PATH
