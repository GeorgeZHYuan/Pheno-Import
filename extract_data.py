#!/usr/bin/env python

import json

extractedData = open('extracted_data.txt', 'a+')
templateFile = open('data_template.txt', 'a')
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
arrayPosition = []
arrayLength = []

extractedData.write('{}'.format(subjID))

while i < len(dataCategories):
        if(isinstance(dataCategories[i], list)):
                arrayPosition.append(i)
                arrayLength.append(len(dataCategories[i]))
        i+=1

i=0
while i < len(dataCategories):

	if(isinstance(dataCategories[i], list)):
		j=0
		#while j < len(dataCategories[i]):
		temp = dataCategories[i][j]
                extractedData.write('\t' + '{}'.format(temp))
		templateFile.write('\t' + '{}'.format(temp))
		j+=1
		i+=1
	else:
		temp = dataCategories[i]
		extractedData.write('\t' + '{}'.format(temp))
		templateFile.write('\t' + '{}'.format(temp))
		i+=1

#Pseduo-code
#For the length of the arrayPostion or arrayLength (should be the same)
#If length of array is 1+
#print new line, ID in first line, a bunch of tabs which reflect the arrayPostion, and print second array elements
#Repeat until no more elements in the array.

i=0
j=0
k=1
if(len(arrayPosition) > 1):        
        while i < len(arrayPosition):
                extractedData.write('\n' + '{}'.format(subjID))
                while j < (arrayPosition[i]):
                        extractedData.write('\t')
			j+=1
			if j > (arrayPosition[i]-1):
				extractedData.write('\t' + '{}'.format(dataCategories[arrayPosition[i]][k]))
		print i
                i+=1

	
subjID+=1

print arrayPosition
print arrayLength
print dataCategories[arrayPosition[0]][0]
#print i

#print extractedData.tell()
#extractedData.seek(-1,2)
#extractedData.read()
#extractedData.write("Testing...")

extractedData.close()

#If array has multiple elements, make a new line with 
