#!/bin/bash

DATA_INTEGRATION_PATH=/home/transmart/transmart/data-integration
TRANSMART_ETL_PATH=/home/transmart/transmart/tranSMART-ETL

set -x   # commands will be printed before execution

$DATA_INTEGRATION_PATH/kitchen.sh -norep=Y \
-file=$TRANSMART_ETL_PATH/Kettle/postgres/Kettle-ETL/create_clinical_data.kjb \
-log=load_clinical_data.log \
-param:DATA_LOCATION=$PH_IMPORT_HOME/import-data/Clinical-data/  \
-param:COLUMN_MAP_FILE=PATIENT_columns.txt \
-param:RECORD_EXCLUSION_FILE=PATIENT_record_exclusion.txt \
-param:WORD_MAP_FILE=PATIENT_words.txt \
-param:LOAD_TYPE=I \
-param:SECURITY_REQUIRED=N \
-param:STUDY_ID=PHENOTIPS_PATIENTS \
-param:TOP_NODE='\Public Studies\PHENOTIPS_PATIENTS\' \
-param:SORT_DIR=/tmp
