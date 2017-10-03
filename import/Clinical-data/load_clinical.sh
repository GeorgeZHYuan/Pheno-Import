DATA_INTEGRATION_PATH=/home/transmart/transmart/data-integration
TRANSMART_ETL_PATH=/home/transmart/transmart/tranSMART-ETL

set -x   # commands will be printed before execution

$DATA_INTEGRATION_PATH/kitchen.sh -norep=Y \
-file=$TRANSMART_ETL_PATH/Kettle/postgres/Kettle-ETL/create_clinical_data.kjb \
-log=load_clinical_data.log \
-param:DATA_LOCATION=/home/transmart/transmart/phenotips-import-data/Clinical-data  \
-param:COLUMN_MAP_FILE=PHENOTIPS_columns.txt \
-param:LOAD_TYPE=I \
-param:SECURITY_REQUIRED=N \
-param:STUDY_ID=testing \
-param:TOP_NODE='\Public Studies\testing\' \
-param:SORT_DIR=/tmp
