#!/bin/bash

# Initialize
PH_HOME=$HOME/Pheno-Import
TM_LOADER_HOME=$HOME/tMDataLoader

# Determine upload instructions
patient_ids=('P0000001' 'P0000002' 'P0000003' 'P0000004')

# Get the patient data from phenotips
python $PH_HOME/src/setup_data_file.py "${patient_ids[@]}"

# Upload to transmart
java -jar $TM_LOADER_HOME/tm_etl.jar -c $PH_HOME/conf/Config.groovy 
