from SQL_Query import SQL_Query
from sets import Set

class Transmart_Database:
	sql = SQL_Query()

	def __init__(self):
		self.study_id = 'NONEXISTANT_DB'
		self.subject_id = '-9999'


	def configure(self, study_id, subject_id='-9999'):
		self.study_id = study_id
		self.subject_id = subject_id

	def get_all_affected_paths(self, direct_paths):
		found_paths = Set(direct_paths)
		new_paths = Set(found_paths)
		while len(new_paths) != 0:	
			discovered_paths = Set()
			for path in new_paths:
				parent_path = self.sql.query("SELECT parent_concept_path FROM i2b2demodata.concept_counts " \
										"WHERE concept_path IN (SELECT c_fullname FROM i2b2metadata.i2b2 " \
										"WHERE sourcesystem_cd='"+self.study_id+"') AND concept_path='"+path+"'")['parent_concept_path']
				if parent_path:
					p_path = parent_path[0]
					if not(p_path in found_paths):
						found_paths.add(p_path)
						discovered_paths.add(p_path)
			new_paths = discovered_paths
		return found_paths

	
	def study_exists(self):
		return self.sql.query("SELECT study_id FROM tm_lz.lt_src_clinical_data WHERE study_id='"+self.study_id+"'")["study_id"]


	def clean_empty_rows (self):
		empty_labels = self.sql.query("SELECT concept_path FROM i2b2demodata.concept_counts WHERE patient_count=0")["concept_path"]
		for path in empty_labels:
			self.sql.execute("DELETE FROM i2b2demodata.concept_counts WHERE concept_path='"+path+"'")
			self.sql.execute("DELETE FROM i2b2demodata.concept_dimension WHERE concept_path='"+path+"'")
			self.sql.execute("DELETE FROM i2b2metadata.i2b2 WHERE c_fullname='"+path+"'")
		if not self.study_exists():
			self.prep_new_study()

	
	def remove_person(self, subject_id):	
		patient_num = self.sql.query("SELECT patient_num FROM i2b2demodata.patient_dimension WHERE sourcesystem_cd LIKE '"+self.study_id+":"+subject_id+"'")['patient_num']
		if patient_num:
			patient_num = patient_num[0]
			direct_concept_paths = self.sql.query("SELECT a.concept_path FROM (i2b2demodata.concept_counts a " \
											"INNER JOIN (SELECT b.concept_path FROM (i2b2demodata.concept_dimension b " 
											"INNER JOIN (SELECT concept_cd FROM i2b2demodata.observation_fact " \
											"WHERE patient_num='"+patient_num+"' AND sourcesystem_cd='"+self.study_id+"') c " \
											"ON b.concept_cd=c.concept_cd)) d ON a.concept_path=d.concept_path)")
			affected_paths = self.get_all_affected_paths(direct_concept_paths['concept_path'])
			for path in affected_paths:
				self.sql.execute("UPDATE i2b2demodata.concept_counts SET patient_count=patient_count-1 WHERE concept_path='"+path+"' AND patient_count > 0")	
			self.sql.execute("DELETE FROM tm_lz.lt_src_clinical_data WHERE subject_id='"+subject_id+"' AND study_id='"+self.study_id+"'")
			self.sql.execute("DELETE FROM i2b2demodata.patient_trial WHERE patient_num='"+patient_num+"' AND trial='"+self.study_id+"'")
			self.sql.execute("DELETE FROM i2b2demodata.patient_dimension WHERE patient_num='"+patient_num+"'AND sourcesystem_cd LIKE '"+self.study_id+":%';")
			self.sql.execute("DELETE FROM i2b2demodata.observation_fact WHERE patient_num='"+patient_num+"' AND sourcesystem_cd='"+self.study_id+"'")
			self.clean_empty_rows()
		else:
			print "Patient " + subject_id + " does not exist"

	def prep_new_study(self):
		self.sql.execute("DELETE FROM tm_lz.lt_src_clinical_data WHERE study_id='"+self.study_id+"'")


db = Transmart_Database()
db.configure("PHENO_TEST")
db.remove_person("P0000002")

		

