from pySQL import pySQL

STUDY_ID = 'PHENO_TEST'
SUBJECT_ID = 'P0000001'

sql_tbl=pySQL("SELECT patient_num FROM i2b2demodata.patient_dimension WHERE sourcesystem_cd LIKE '"+STUDY_ID+":"+SUBJECT_ID+"'")

patient_num=sql_tbl['patient_num'][0]

print "Patient P0000001's sql patient number is: " + patient_num
