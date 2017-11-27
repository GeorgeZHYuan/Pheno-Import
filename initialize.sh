# Analysis Job Variable
source $HOME/.Pheno_Settings.config

# Upload variables
variable=("$@")
TM_STUDY_ID=${variable[0]}
TM_TOP_NODE=${variable[1]}
TM_STUDY_NAME=${variable[2]}
PHENO_ADDRESS=${variable[3]}
PHENO_USER=${variable[4]}
PHENO_PWD=${variable[5]}

#cmd_1="SELECT name_char FROM i2b2demodata.concept_dimension WHERE sourcesystem_cd='PHENOTEST' ORDER BY concept_path ASC LIMIT 1;"
#TM_STUDY_NAME=$(echo $cmd_1 | sudo -u postgres psql -t transmart)
#TM_STUDY_NAME=$(echo "${TM_STUDY_NAME//" "}")

#cmd_2="SELECT concept_path FROM i2b2demodata.concept_dimension WHERE sourcesystem_cd='PHENOTEST' ORDER BY concept_path ASC LIMIT 1;"
#TM_TOP_NODE=$(echo $cmd_2 | sudo -u postgres psql -t transmart)
#TM_TOP_NODE=$(echo ${TM_TOP_NODE//"\\"})
#TM_TOP_NODE=$(echo ${TM_TOP_NODE//$TM_STUDY_NAME})

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


