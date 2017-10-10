#!/usr/bin/env python

import json

patientData = open('sample_data.txt','r')
extractedData = open('extracted_data.txt', 'a')
#text=patientData.read()
#print(text)

wjson = patientData.read()
wjdata = json.loads(wjson)

#print wjdata['report_id']

extractedData.write(wjdata['report_id'])
