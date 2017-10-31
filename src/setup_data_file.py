import sys
from upload_vars import *
from Data_File import Data_File
from phenotips_REST import phenotips_REST

sys.path.insert(0, PH_HOME+'/templates')
from JSON_labels import LABEL_FORMATS

patient_ids = sys.argv[1:]
patients_found = []
patients_ommited = []

data_file = Data_File(TM, PH_HOME)

for patient_id in patient_ids:
	response = phenotips_REST(PH, 'patients/'+patient_id)
	if isinstance(response, int):
		patients_ommited.append(patient_id)
	else:
		data_file.add_patient(response, LABEL_FORMATS)
		patients_found.append(patient_id)

data_file.generate_file()
