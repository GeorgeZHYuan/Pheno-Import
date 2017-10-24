#!/usr/bin/env python

import json
import sys

extractedData = open('extracted_data.txt', 'a+')
#templateFile = open('data_template.txt', 'a')
#wjson = open('sample_data.txt','r').read()
#wjdata = json.loads(wjson)

#print str(sys.argv)


#wjson = open(data,'r').read()	
wjdata = json.loads('{"sex":"M","genes":[{"id":"ENSG00000053770","gene":"AP5M1","status":"solved","strategy":["sequencing"]},{"id":"ENSG00000221946","gene":"FXYD7","status":"carrier","strategy":["deletion"]},{"id":"ENSG00000233642","gene":"GPR158-AS1","status":"rejected","strategy":["familial_mutation"]}],"date":"2017-10-10T18:01:58.000Z","disorders":[{"id":"MIM:137100","label":"IMMUNOGLOBULIN A DEFICIENCY 1"},{"id":"MIM:614082","label":"FANCONI ANEMIA, COMPLEMENTATION GROUP G"},{"id":"MIM:310400","label":"MYOPATHY, CENTRONUCLEAR, X-LINKED"},{"id":"MIM:614024","label":"PROTEIN Z DEFICIENCY"},{"id":"MIM:470000","label":"RIBOSOMAL PROTEIN S4, Y-LINKED, 1"},{"id":"MIM:475000","label":"GROWTH CONTROL, Y-CHROMOSOME INFLUENCED"},{"id":"MIM:426000","label":"LYSINE-SPECIFIC DEMETHYLASE 5D"},{"id":"MIM:553000","label":"ONCOCYTOMA"},{"id":"MIM:608631","label":"ASPERGER SYNDROME, SUSCEPTIBILITY TO, 2"}],"contact":[{"id":"xwiki:XWiki.Admin","email":"support@phenotips.org","name":"Administrator","institution":"http://phenotips.org/"}],"meta":{"hgnc_version":"2017-07-18T13:03:51.594Z","phenotips_version":"1.3.4","ordo_version":"2.3","omim_version":"2017-07-18T18:53:21.802Z","hpo_version":"releases/2017-06-30"},"reporter":"Admin","id":"P0000001","last_modified_by":"Admin","features":[],"variants":[{"segregation":"NA","sanger":"NA","gene":"ENSG00000053770","cdna":"1094C>T","effect":"NA","protein":"Gly438Pro","end_position":"5","start_position":"1","zygosity":"heterozygous","interpretation":"likely_benign","chromosome":"5","inheritance":"NA","reference_genome":"GRCh38"}],"global_mode_of_inheritance":[{"id":"HP:0003745","label":"Sporadic"},{"id":"HP:0010985","label":"Gonosomal inheritance"},{"id":"HP:0001450","label":"Y-linked inheritance"},{"id":"HP:0001427","label":"Mitochondrial inheritance"}],"apgar":{"apgar5":5,"apgar1":5},"external_id":"Patient0","solved":{"status":"unsolved"},"patient_name":{"first_name":"Jandro","last_name":"Alleh"},"specificity":{"score":0,"server":"monarchinitiative.org","date":"2017-10-16T20:27:31.691Z"},"date_of_birth":{"month":7,"year":1988,"day":6},"last_modification_date":"2017-10-16T20:27:54.000Z","family_history":{"miscarriages":false,"consanguinity":false,"affectedRelatives":true},"prenatal_perinatal_history":{"icsi":false,"assistedReproduction_iui":false,"twinNumber":null,"maternal_age":0,"assistedReproduction_surrogacy":null,"gestation":40,"assistedReproduction_donorsperm":null,"paternal_age":0,"assistedReproduction_donoregg":false,"ivf":true,"assistedReproduction_fertilityMeds":true,"multipleGestation":false},"life_status":"alive","clinicalStatus":"unaffected","report_id":"P0000001","nonstandard_features":[],"notes":{"genetic_notes":"Genetic Data Notes","diagnosis_notes":"Additional Comments","medical_history":"","indication_for_referral":"Indication for referral","prenatal_development":"","family_history":""},"ethnicity":{"maternal_ethnicity":["African Americans","Korean"],"paternal_ethnicity":["Arabs","Luba","Japanese"]},"clinical-diagnosis":[{"id":"ORDO:121427","label":"arylsulfatase A"},{"id":"ORDO:181111","label":"F-box protein 7"},{"id":"ORDO:426145","label":"G protein-coupled receptor 161"},{"id":"ORDO:449094","label":"endoplasmic reticulum aminopeptidase 1"}]}')

#def convertJSON(data):
	
#dataCategories = [wjdata.get("report_id"), wjdata.get("external_id"), wjdata.get('patient_name',{}).get('first_name'), 
#		wjdata.get('patient_name',{}).get('last_name'), wjdata.get("sex"), wjdata.get("life_status"), wjdata.get("date_of_birth",{}).get("year"),
#		wjdata.get("date_of_birth",{}).get("month"), wjdata.get("date_of_birth",{}).get("day"), wjdata.get("date_of_death",{}).get("year"), 
#		wjdata.get("date_of_death",{}).get("month"), wjdata.get("date_of_death",{}).get("day"), wjdata.get('ethnicity').get('maternal_ethnicity'),
#		wjdata.get('ethnicity').get('paternal_ethnicity')]

labels=[ ["report_id"], ["external_id"], ["patient_name", "first_name"], ["patient_name", "last_name"], ["sex"], ["life_status"], ["date_of_birth", "year"], ["date_of_birth", "month"], ["date_of_birth", "day"], ["date_of_death", "year"], ["date_of_death", "month"], ["date_of_death", "day"], ["ethnicity", "maternal_ethnicity"], ["ethnicity", "paternal_ethnicity"] ]

extractedInformation = []

def parseData(label,json):
	print parseData
	iteration = 0
	arraySize = len(label)
	for current in range(0, arraySize):
		innerArray = len(label[current])
		if (innerArray == 1):
			extractedInformation.append(json.get(label[current][0],{}))
			iteration+=1
		else:
			extractedInformation.append(json.get(label[current][0],{}).get(label[current][1]))
			iteration+=1
		#print extractedInformation[current]
		if ( isinstance(extractedInformation[iteration-1], list)):
			temp = extractedInformation[iteration-1]
			extractedInformation.remove(temp)
			print temp
			iteration-=1
			count=len(temp)
			for element in range(0, count):
				extractedInformation.append(temp[element])
				iteration+=1

parseData(labels,wjdata)

print extractedInformation
	
#for data in dataCategories:
#	print data

#	extractedData.write('\n')

#	with open('tmp/test.tmp', 'a') as file:
#		max_array_size = 1
#		for label in dataCategories:
#			if (isinstance(label, list)):
#				max_array_size = max(max_array_size, len(label))
#				file.write(str(label[0])+'\t')
#			else:
#				file.write(str(label)+'\t')
#		file.write('\n')
#		for j in range(1, max_array_size):
#			file.write(str(dataCategories[0])+'\t')
#			for label2 in dataCategories[1:]:
#				if (isinstance(label2, list)):
#					if len(label2) > j:
#						file.write(str(label2[j])+'\t')
#				else:
#					#file.write(str(label2)+'\t')
#					file.write('\t')
#			file.write('\n')

#convertJSON(wjdata)

extractedData.close()
