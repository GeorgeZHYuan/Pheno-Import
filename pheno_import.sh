#!/bin/bash

source $HOME/.Pheno_Settings.config

# Manually set variables
upload_vars=('Public Studies' 'Phenotips' 'PHENOTEST' 'localhost:10000' 'Admin' 'admin')
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004' 'P0000005' 'P0000006')

# Get variables from arguments if they exist
if [ $# -ne 0 ]; then
	upload_vars=("{$@:1:6}")
	patient_ids=("${@:7}")
fi

# Get the patient data from phenotips
$PH_HOME/initialize.sh "${upload_vars[@]}"
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $TM_DATALOADER_PATH/tm_etl.jar -c $TM_CONFIG_FILE_PATH
