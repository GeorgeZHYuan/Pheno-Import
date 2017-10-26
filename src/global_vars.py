# Setup python global vars
import sys
from Data_Types import *

# Pheno-Import Paths
PH_HOME='/home/transmart/Pheno-Import'

# Transmart Variables
TM = Transmart_Study()
TM.TOP_NODE = 'Public Studies'
TM.STUDY_NAME = 'Phenotips'
TM.STUDY_ID = 'PHENOTEST'

# Phenotips Variables
PH = Pheno_Settings()
PH.ADDRESS = 'localhost:10000'
PH.USER = 'Admin'
PH.PWD = 'admin'
