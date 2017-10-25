import sys
from Data_File import Data_File
from global_vars import TM, PH, PH_HOME
from phenotips_REST import phenotips_REST
from parse_data import parse_data

patient_ids = sys.argv[1:]
patients_found = []
patients_ommited = []

data_file = Data_File(PH_HOME+'/templates/data_labels.txt')
data_file.set_location(PH_HOME, TM.TOP_NODE, TM.STUDY_NAME)

for patient_id in patient_ids:
	response = phenotips_REST('patients/'+patient_id)
	if isinstance(response, int):
		patients_ommited.append(patient_id)
	else:
		data = [TM.STUDY_ID]+parse_data(response, PH.JSON_LABELS)
		data_file.add_patient(data)
		patients_found.append(patient_id)

data_file.generate_file()
