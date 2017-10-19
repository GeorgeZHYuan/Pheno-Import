#!/usr/bin/env python

import json
import sys

extractedData = open('import-data/Clinical-data/PHENOTIPS_clinical.txt', 'w')
templateFile = open('templates/phenotips_clinincal_labels.txt', 'r')
#wjson = open('sample_data.txt','r').read()
#wjdata = json.loads(wjson)

with templateFile as myfile:
	template=myfile.readlines()

#print template[0]

extractedData.close()
extractedData = open('import-data/Clinical-data/PHENOTIPS_clinical.txt', 'a+')

inFile = sys.argv[1]

#print str(inFile)

#with open(inFile,'r') as i:
#    lines = i.readlines()

# Input a variable wwith a string with the JSON stored in it
def convertJSON(data):
	
	#wjson = open(data,'r').read()	
	wjdata = json.loads(data)

	extractedData.write(template[0])
	#extractedData.write('\n')

	dataCategories = [wjdata.get("report_id"), wjdata.get("external_id"), wjdata.get('patient_name',{}).get('first_name'), 
		wjdata.get('patient_name',{}).get('last_name'), wjdata.get("sex"), wjdata.get("life_status"), wjdata.get("date_of_birth",{}).get("year"),
		wjdata.get("date_of_birth",{}).get("month"), wjdata.get("date_of_birth",{}).get("day"), wjdata.get("date_of_death",{}).get("year"), 
		wjdata.get("date_of_death",{}).get("month"), wjdata.get("date_of_death",{}).get("day"), wjdata.get('ethnicity').get('maternal_ethnicity'),
		wjdata.get('ethnicity').get('paternal_ethnicity')]

	with extractedData as file:
		max_array_size = 1
		file.write(wjdata.get("report_id"))
		file.write('\t')
		for label in dataCategories:
			if (isinstance(label, list)):
				max_array_size = max(max_array_size, len(label))
				file.write(str(label[0])+'\t')
			else:
				file.write(str(label)+'\t')
		file.write('\n')
		for j in range(1, max_array_size):
			file.write(str(dataCategories[0])+'\t')
			for label2 in dataCategories[0:]:
				if (isinstance(label2, list)):
					if len(label2) > j:
						file.write(str(label2[j])+'\t')
				else:
					#file.write(str(label2)+'\t')
					file.write('\t')
			file.write('\n')
			
convertJSON(inFile)

#extractedData.close()
