import os
import shutil
from shutil import copyfile
from Data_Types import Transmart_Study

class Data_File:
	def __init__(self, tm, hm_dir):		
		self.study_id = tm.STUDY_ID
		self.path = hm_dir+'/import-data'+'/'+tm.TOP_NODE+'/'+tm.STUDY_NAME+'/ClinicalData'
		self.patient_info_list = []
		self.setup_directories(hm_dir, tm)


	def setup_directories(self, hm_dir, tm):
		shutil.rmtree(hm_dir+'/import-data', ignore_errors=True)
		os.makedirs(self.path)
		copyfile(hm_dir+'/templates/column_file.txt', self.path+'/'+tm.STUDY_NAME+'_'+tm.STUDY_ID+'_Mapping_File.txt')
		copyfile(hm_dir+'/templates/data_labels.txt', self.path+'/'+'clinical.txt')


	def add_patient(self, json, column_labels):
		extractedInformation = [self.study_id]
		for label in column_labels:
			if (len(label) == 1):
				value = json.get(label[0],{})
				if value == {}:
					value = ''
				extractedInformation.append(value)
			else:
				temp = json.get(label[0],{})
				for i in range(1, len(label)):
					temp = temp.get(label[i],{})
				if temp == {}:
					temp = ''
				extractedInformation.append(temp)
		self.patient_info_list.append(extractedInformation)
		

	def generate_file(self):		
		with open(self.path+'/clinical.txt', 'a+') as file:
			for patient_info in self.patient_info_list:
				max_array_size = 1
				for item in patient_info:
					if (isinstance(item, list)):
						max_array_size = max(max_array_size, len(item))
						file.write(str(item[0])+'\t')
					else:
						file.write(str(item)+'\t')
				file.write('\n')
				for j in range(1, max_array_size):
					file.write(str(patient_info[0])+'\t'+patient_info[1]+'\t')
					for item2 in patient_info[2:]:
						if (isinstance(item2, list)):
							if len(item2) > j:
								file.write(str(item2[j])+'\t')
						else:
							file.write('\t')
					file.write('\n')
		file.close()

		
