class Data_File:
	def __init__(self, label_file="templates/data_labels.txt"):
		self.label_location = label_file
		self.__set_labels()
		self.reset()


	def reset (self):
		self.patient_info_list = []
		self.data_location = ""
		

	def __set_labels(self):
		self.labels = open(self.label_location).readline()


	def set_location(self, hm_dir, top_node, study_id):
		self.data_location = hm_dir+'/import-data'+'/'+top_node+'/'+study_name+'/ClinicalData/PHENOTIPS_clinical.txt'


	def add_patient(self, patient_data):
		self.patient_info_list.append(patient_data)


	def generate_file(self):
		file = open(self.data_location, 'w+')
		file.write(self.labels)
		file.close
		
		with open(self.data_location, 'a+') as file:
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

		
