#!/usr/bin/env python
import json
import sys

extractedData = open('extracted_data.txt', 'a+')
#templateFile = open('data_template.txt', 'a')
#wjson = open('sample_data.txt','r').read()
#wjdata = json.loads(wjson)
inFile = sys.argv[1]

#print str(sys.argv)

#with open(inFile,'r') as i:
#    lines = i.readlines()

def convertJSON(data):
	
	wjson = open(data,'r').read()	
	wjdata = json.loads(wjson)

	dataCategories = [wjdata.get("report_id"), wjdata.get("external_id"), wjdata.get('patient_name',{}).get('first_name'), 
		wjdata.get('patient_name',{}).get('last_name'), wjdata.get("sex"), wjdata.get("life_status"), wjdata.get("date_of_birth",{}).get("year"),
		wjdata.get("date_of_birth",{}).get("month"), wjdata.get("date_of_birth",{}).get("day"), wjdata.get("date_of_death",{}).get("year"), 
		wjdata.get("date_of_death",{}).get("month"), wjdata.get("date_of_death",{}).get("day"), wjdata.get('ethnicity').get('maternal_ethnicity'),
		wjdata.get('ethnicity').get('paternal_ethnicity')]

	extractedData.write('\n')

	with open('tmp/test.tmp', 'a') as file:
		max_array_size = 1
		for label in dataCategories:
			if (isinstance(label, list)):
				max_array_size = max(max_array_size, len(label))
				file.write(str(label[0])+'\t')
			else:
				file.write(str(label)+'\t')
		file.write('\n')
		for j in range(1, max_array_size):
			file.write(str(dataCategories[0])+'\t')
			for label2 in dataCategories[1:]:
				if (isinstance(label2, list)):
					if len(label2) > j:
						file.write(str(label2[j])+'\t')
				else:
					#file.write(str(label2)+'\t')
					file.write('\t')
			file.write('\n')
			
convertJSON(inFile)

extractedData.close()
