from Data_File import Data_File

TOP_NODE = "Public Studies"
STUDY_ID = "PHENO_TEST"

class Pheno_Settings:
	pass
pheno = Pheno_Settings
pheno.HOST = "localhost"
pheno.PORT = "10000"
pheno.USER = "Admin"
pheno.PWD = "admin"

column_labels=[ ["report_id"], ["external_id"], ["patient_name", "first_name"], ["patient_name", "last_name"], ["sex"], ["life_status"], ["date_of_birth", "year"], ["date_of_birth", "month"], ["date_of_birth", "day"], ["date_of_death", "year"], ["date_of_death", "month"], ["date_of_death", "day"], ["ethnicity", "maternal_ethnicity"], ["ethnicity", "paternal_ethnicity"] ]
