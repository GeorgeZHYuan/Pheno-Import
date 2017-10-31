DIRECT_LABELS=[
["report_id"], ["external_id"], 
["patient_name", "first_name"], ["patient_name", "last_name"], 
["sex"], ["life_status"], 
["date_of_birth", "year"], ["date_of_birth", "month"], ["date_of_birth", "day"], ["date_of_death", "year"], ["date_of_death", "month"], ["date_of_death", "day"], 
["ethnicity", "maternal_ethnicity"], ["ethnicity", "paternal_ethnicity"],

["family_history", "affectedRelatives"], ["family_history", "consanguinity"],  ["family_history", "miscarriages"],

["prenatal_perinatal_history", "multipleGestation"], ["prenatal_perinatal_history", "twinNumber"], ["prenatal_perinatal_history", "gestation"], 
["prenatal_perinatal_history", "assistedReproduction_fertilityMeds"], ["prenatal_perinatal_history", "IUI"], ["prenatal_perinatal_history", "ivf"], ["prenatal_perinatal_history", "icsi"], ["prenatal_perinatal_history", "assistedReproduction_surrogacy"], ["prenatal_perinatal_history", "assistedReproduction_donoregg"], ["prenatal_perinatal_history", "assistedReproduction_donorsperm"], ["prenatal_perinatal_history", "maternal_age"], ["prenatal_perinatal_history", "paternal_age"], ["apgar", "apgar1"], ["apgar", "apgra5"], 


["allergies"],

["clinicalStatus"],

["solved", "status"], ["solved", "pubmed_id"]
]

STRUCTURED_LABELS=[
[['global_mode_of_inheritance', 'global_age_of_onset', 'clinical-diagnosis', 'disorders'], {'id':'str', 'label':'str'}]
]


LABEL_FORMATS = [DIRECT_LABELS, STRUCTURED_LABELS]
