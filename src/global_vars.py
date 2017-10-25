import sys
from Data_Types import *

# Pheno-Import Paths
PH_HOME='/home/transmart/Pheno-Import'
TM_LOADER_HOME='/home/tMDataLoader'

# Transmart Variables
TM = Transmart_Study()
TM.TOP_NODE = "Public Studies"
TM.STUDY_NAME = "Phenotips"
TM.STUDY_ID = "PHENOTEST"

# Phenotips Variables
PH = Pheno_Settings()
PH.ADDRESS = "localhost:10000"
PH.USER = "Admin"
PH.PWD = "admin"
PH.JSON_LABELS=[["report_id"], ["external_id"], ["patient_name", "first_name"], ["patient_name", "last_name"], ["sex"], ["life_status"], ["date_of_birth", "year"], ["date_of_birth", "month"], ["date_of_birth", "day"], ["date_of_death", "year"], ["date_of_death", "month"], ["date_of_death", "day"], ["ethnicity", "maternal_ethnicity"], ["ethnicity", "paternal_ethnicity"]]

