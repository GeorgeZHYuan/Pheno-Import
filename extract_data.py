#!/usr/bin/env python

import json

extractedData = open('extracted_data.txt', 'a')
wjson = open('sample_data.txt','r').read()
wjdata = json.loads(wjson)
subjID = 1

dataCategories = ["report_id", "external_id", "patient_name"]

extractedData.write('\n')

#Make for-loop for elements in the array
i = 0
extractedData.write("{}".format(subjID))

#while i < len(dataCategories):
#	if dataCategories[i] in wjson:
#		extractedData.write('\t' + wjdata[dataCategories[i]])
#		i+=1
#	else:
#		i+=1

while i < len(dataCategories):
	try:
		extractedData.write('\t' + wjdata[dataCategories[i]])
		i+=1
	except:
		i+=1

subjID+=1

extractedData.close()
