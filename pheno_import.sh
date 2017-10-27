#!/bin/bash

# Initialize variables
source conf/Pheno_Settings.config
src/initialize.sh $PH_HOME "$@"

# Determine patients to upload
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $PH_HOME/tMDataLoader/tm_etl.jar -c $PH_HOME/conf/Config.groovy 
