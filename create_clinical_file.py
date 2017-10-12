import sys

phenotips_labels = open(sys.argv[4]).readline()
phenotips_labels = phenotips_labels[7:]

existing_labels = open('tmp/existing_labels.tmp').readline()

column_labels = existing_labels+phenotips_labels
print column_labels
