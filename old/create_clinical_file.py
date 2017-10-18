import sys

phenotips_labels = open(sys.argv[4]).readline()
phenotips_labels = phenotips_labels[7:]
existing_labels = open('tmp/existing_labels.tmp').readline()
column_labels = existing_labels+phenotips_labels

with open('tmp/clinical_file_labels.tmp', 'w') as clin_file:
	clin_file.write(column_labels)
