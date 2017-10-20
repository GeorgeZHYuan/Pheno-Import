from SQL_Query import SQL_Query
from sets import Set

def find_affected_paths (direct_concept_paths):
	found_paths = Set(direct_concept_paths)
	new_paths = Set(found_paths)
	while len(new_paths) != 0:	
		discovered_paths = Set()
		for path in new_paths:
			parent_path = sql.query("SELECT parent_concept_path FROM i2b2demodata.concept_counts WHERE concept_path IN (SELECT c_fullname FROM i2b2metadata.i2b2 WHERE sourcesystem_cd='"+STUDY_ID+"') AND concept_path='"+path+"'")['parent_concept_path']
			if parent_path:
				p_path = parent_path[0]
				if not(p_path in found_paths):
					found_paths.add(p_path)
					discovered_paths.add(p_path)
		new_paths = discovered_paths
	return found_paths

STUDY_ID = 'GSEXXXX'
SUBJECT_ID = '1'
patient_num = '0'
sql = SQL_Query()

patient_num = sql.query("SELECT patient_num FROM i2b2demodata.patient_dimension WHERE sourcesystem_cd LIKE '"+STUDY_ID+":"+SUBJECT_ID+"'")['patient_num'][0]
direct_concept_paths = sql.query("SELECT a.concept_path FROM (i2b2demodata.concept_counts a INNER JOIN (SELECT b.concept_path FROM (i2b2demodata.concept_dimension b INNER JOIN (SELECT concept_cd FROM i2b2demodata.observation_fact WHERE patient_num='"+patient_num+"' AND sourcesystem_cd='"+STUDY_ID+"') c ON b.concept_cd=c.concept_cd)) d ON a.concept_path=d.concept_path)")['concept_path']

affected_paths = find_affected_paths(direct_concept_paths)
for path in affected_paths:
	sql.execute("UPDATE i2b2demodata.concept_counts SET patient_count=patient_count-1 WHERE concept_path='"+path+"'")

sql.execute("DELETE FROM tm_lz.lt_src_clinical_data WHERE subject_id='"+SUBJECT_ID+"'")
sql.execute("DELETE FROM i2b2demodata.patient_trial WHERE patient_num='"+patient_num+"'")
sql.execute("DELETE FROM i2b2demodata.patient_dimension WHERE patient_num='"+patient_num+"'")
sql.execute("DELETE FROM i2b2demodata.observation_fact WHERE patient_num='"+patient_num+"'")


