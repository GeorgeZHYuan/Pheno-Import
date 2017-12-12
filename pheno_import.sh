#!/bin/bash
source $HOME/.pheno_settings.config

# Manually set variables
# upload_vars(6 elements): Study ID | Phenotips Address | Phenotips Username | Phenotips Password
upload_vars=('TOP NODE' 'STUDY NAME' 'http://localhost:10000' 'Admin' 'admin')
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004' 'P0000005' 'P0000006')

# Get and overwrite upload variables if terminal arguments exist
if [ $# -ne 0 ]; then
	echo 'Obtained upload variables from arguments'
	upload_vars=("${@:1:5}") 
	patient_ids=("${@:6}")
fi
echo "Patient ids: ${patient_ids[@]}"

# Transfer bash upload variables to python variables
$PH_HOME/conf/initialize.sh "${upload_vars[@]}"

# Build Upload tables from patient data using pythong script
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart using upload tables
java -jar $TM_DATALOADER_PATH/tm_etl.jar -c $TM_CONFIG_FILE_PATH
