import sys
from Data_File import Data_File
from global_vars import TM, JSON_LABELS, PH_HOME
from phenotips_REST import phenotips_REST

patient_ids = sys.argv[1:]
patients_found = []
patients_ommited = []

data_file = Data_File(TM, PH_HOME)

for patient_id in patient_ids:
	response = phenotips_REST('patients/'+patient_id)
	if isinstance(response, int):
		patients_ommited.append(patient_id)
	else:
		print response["allergies"]
		data_file.add_patient(response, JSON_LABELS)
		patients_found.append(patient_id)

data_file.generate_file()
