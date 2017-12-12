# Analysis Job Variable
source $HOME/.Pheno_Settings.config

# Upload variables
variable=("$@")
TM_TOP_NODE=${variable[0]}
TM_STUDY_NAME=${variable[1]}
PHENO_ADDRESS=${variable[2]}
PHENO_USER=${variable[3]}
PHENO_PWD=${variable[4]}

# Get study id base off study name and top folder
TOP_NODE_NAME="\\"$TM_TOP_NODE"\\"$TM_STUDY_NAME"\\"
PSQL_COMMAND="SELECT sourcesystem_cd FROM i2b2demodata.concept_dimension WHERE name_char='$TM_STUDY_NAME' AND concept_path='$TOP_NODE_NAME' ORDER BY sourcesystem_cd ASC;"
STUDY_ID=$(echo $(psql -d transmart -U $TRANSMART_DB_USR -h $TRANSMART_DB_HOST -c "$PSQL_COMMAND" -t))
TM_STUDY_ID=$(echo ${STUDY_ID//"\\"})

echo "STUDYID:" $TM_STUDY_ID
echo "TOPNODE:" $TM_TOP_NODE
echo "STUDYNAME:" $TM_STUDY_NAME

# Convert to python variables
echo "# Setup python global variable
import sys
from Data_Types import *

# Pheno-Import Paths
PH_HOME='$PH_HOME'

# Transmart Variables
TM = Transmart_Study()
TM.TOP_NODE = '$TM_TOP_NODE'
TM.STUDY_NAME = '$TM_STUDY_NAME'
TM.STUDY_ID = '$TM_STUDY_ID'

# Phenotips Variables
PH = Pheno_Settings()
PH.ADDRESS = '$PHENO_ADDRESS'
PH.USER = '$PHENO_USER'
PH.PWD = '$PHENO_PWD'" > $PH_HOME/src/upload_vars.py


