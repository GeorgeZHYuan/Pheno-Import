from collections import OrderedDict

DIRECT_LABELS=[
['report_id'], ['external_id'], 
['patient_name', 'first_name'], ['patient_name', 'last_name'], 
['sex'], ['life_status'], 
['date_of_birth', 'year'], ['date_of_birth', 'month'], ['date_of_birth', 'day'], ['date_of_death', 'year'], ['date_of_death', 'month'], ['date_of_death', 'day'], 
['ethnicity', 'maternal_ethnicity'], ['ethnicity', 'paternal_ethnicity'],
['family_history', 'affectedRelatives'], ['family_history', 'consanguinity'],  ['family_history', 'miscarriages'],
['prenatal_perinatal_history', 'multipleGestation'], ['prenatal_perinatal_history', 'twinNumber'], ['prenatal_perinatal_history', 'gestation'], ['prenatal_perinatal_history', 'assistedReproduction_fertilityMeds'], ['prenatal_perinatal_history', 'IUI'], ['prenatal_perinatal_history', 'ivf'], ['prenatal_perinatal_history', 'icsi'], ['prenatal_perinatal_history', 'assistedReproduction_surrogacy'], ['prenatal_perinatal_history', 'assistedReproduction_donoregg'], ['prenatal_perinatal_history', 'assistedReproduction_donorsperm'], ['prenatal_perinatal_history', 'maternal_age'], ['prenatal_perinatal_history', 'paternal_age'], ['apgar', 'apgar1'], ['apgar', 'apgra5'], 
['allergies'],
['clinicalStatus'],
['solved', 'status'], ['solved', 'pubmed_id']
]

STRUCTURED_LABELS=[
[['global_mode_of_inheritance', 'global_age_of_onset', 'clinical-diagnosis', 'disorders'], OrderedDict([('id','str'), ('label','str')])],
[['variants'], OrderedDict([('dbsnp','str'), ('zygosity','str'), ('chromosome','int'), ('inheritance','str'), ('end_position','int'), ('effect','str'), ('evidence','arr'), ('reference_genome','str'),('start_position','int'), ('segregation','str'), ('interpretation','str'), ('sanger','str'), ('gene','str'), ('transcript','str'), ('protein','str'), ('cdna','str')])],
[['genes'],OrderedDict([('status','str'), ('gene','str'), ('id','str'), ('strategy','str')])]
]

SPLIT_LABELS=[
['features', {'type':'prenatal_phenotype'}, OrderedDict([('id','str'), ('observed','str'), ('type', 'str'), ('label', 'str')])],
['nonstandard_features', {'type':'prenatal_phenotype'}, OrderedDict([('observed','str'), ('type', 'str'), ('categories', OrderedDict([('id', 'str'), ('label', 'str')])), ('label', 'str')])],
['features', {'type':'phenotype'}, OrderedDict([('label','str'), ('observed','str'), ('qualifiers', OrderedDict([('type','str'), ('id','str'), ('label','str')])), ('type','str'), ('id','str')])],
['nonstandard_features', {'type':'phenotype'}, OrderedDict([('label','str'), ('observed','str'),  ('type','str'), ('qualifiers', OrderedDict([('type','str'), ('id','str'), ('label','str')])), ('categories', OrderedDict([('id', 'str'), ('label', 'str')]))])]
]

LABEL_FORMATS = [DIRECT_LABELS, STRUCTURED_LABELS, SPLIT_LABELS]
