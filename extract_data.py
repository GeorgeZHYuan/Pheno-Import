#!/usr/bin/env python

import json

extractedData = open('extracted_data.txt', 'a')
wjson = open('sample_data.txt','r').read()
wjdata = json.loads(wjson)
subjID = 1

dataCategories = [wjdata.get("report_id"), wjdata.get("external_id"), wjdata.get('patient_name',{}).get('first_name'), 
	wjdata.get('patient_name',{}).get('last_name'), wjdata.get("sex"), wjdata.get("life_status"), wjdata.get("date_of_birth",{}).get("year"),
	wjdata.get("date_of_birth",{}).get("month"), wjdata.get("date_of_birth",{}).get("day"), wjdata.get("date_of_death",{}).get("year"), 
	wjdata.get("date_of_death",{}).get("month"), wjdata.get("date_of_death",{}).get("day")]

extractedData.write('\n')

i=0
j=0
extractedData.write("{}".format(subjID))

while i < len(dataCategories):
	try:
		temp = dataCategories[i]
		extractedData.write('\t' + "{}".format(temp))
		i+=1
	except:
		i+=1

subjID+=1

print wjdata.get("ethnicity",{}).get("maternal_ethnicity")

extractedData.close()
