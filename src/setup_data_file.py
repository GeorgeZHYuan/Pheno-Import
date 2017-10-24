import sys

from Data_File import Data_File

from global_vars import TOP_NODE, STUDY_ID
from phenotips_REST import phenotips_REST
from parse_data import parse_data

patient_ids = sys.argv[1:]
patients_found = []
patients_ommited = []

data_file = Data_File()
data_file.set_location(TOP_NODE, STUDY_ID)

for patient_id in patient_ids:
	response = phenotips_REST('patients/'+patient_id)
	if isinstance(response, int):
		patients_ommited.append(patient_id)
	else:
		data = parse_data(response)
		data_file.add_patient(data)
		patients_found.append(patient_id)

data_file.generate_file()
