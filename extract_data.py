#!/usr/bin/env python

import json

extractedData = open('extracted_data.txt', 'a')
wjson = open('sample_data.txt','r').read()
wjdata = json.loads(wjson)
subjID = 1

dataCategories = [wjdata.get("report_id"), wjdata.get("external_id"), wjdata.get('patient_name',{}).get('first_name'), 
	wjdata.get('patient_name',{}).get('last_name'), wjdata.get("sex"), wjdata.get("life_status"), wjdata.get("date_of_birth",{}).get("year"),
	wjdata.get("date_of_birth",{}).get("month"), wjdata.get("date_of_birth",{}).get("day"), wjdata.get("date_of_death",{}).get("year"), 
	wjdata.get("date_of_death",{}).get("month"), wjdata.get("date_of_death",{}).get("day"), wjdata.get('ethnicity').get('maternal_ethnicity'),
	wjdata.get('ethnicity').get('paternal_ethnicity')]

extractedData.write('\n')

i=0
j=0
extractedData.write('{}'.format(subjID))

while i < len(dataCategories):

	if(isinstance(dataCategories[i], list)):
		print isinstance(dataCategories[i], list)
		#length=len(wjdata.get('ethnicity').get('maternal_ethnicity'))
		j=0
		while j < len(wjdata.get('ethnicity').get('maternal_ethnicity')):
			temp = dataCategories[i][j]
			extractedData.write('\t' + '{}'.format(temp))
			j+=1
		i+=1
	else:
		temp = dataCategories[i]
		extractedData.write('\t' + '{}'.format(temp))
		i+=1
	
subjID+=1

#print isinstance(wjdata.get('ethnicity').get('maternal_ethnicity'), list)
#print len(wjdata.get('ethnicity').get('maternal_ethnicity'))
#print wjdata.get('ethnicity').get('maternal_ethnicity')[0]

extractedData.close()

#Add data in array to templates file
