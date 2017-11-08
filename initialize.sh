# Analysis Job Variable
source $HOME/.Pheno_Settings.config

# Upload variables
variable=("$@")
TM_TOP_NODE=${variable[0]}
TM_STUDY_NAME=${variable[1]}
TM_STUDY_ID=${variable[2]}
PHENO_ADDRESS=${variable[3]}
PHENO_USER=${variable[4]}
PHENO_PWD=${variable[5]}

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


