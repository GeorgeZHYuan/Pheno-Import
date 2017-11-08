import sys
import requests
from upload_vars import *
from Data_File import Data_File

sys.path.insert(0, PH_HOME+'/templates')
from JSON_labels import LABEL_FORMATS

patient_ids = sys.argv[1:]
patients_found = []
patients_ommited = []
data_file = Data_File(TM, PH_HOME)

for patient_id in patient_ids:
	print "getting patient:" + patient_id
	r = requests.get(PH.ADDRESS+'/rest/patients/'+patient_id, auth=(PH.USER, PH.PWD))
	if r.status_code != 200:
		patients_ommited.append(patient_id)
	else:
		data_file.add_patient(r.json(), LABEL_FORMATS)
		patients_found.append(patient_id)

data_file.generate_file()
