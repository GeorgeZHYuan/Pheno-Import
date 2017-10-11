import sys

phenotips_labels = open(sys.argv[4]).readline()
phenotips_labels = phenotips_labels[7:]
print(phenotips_labels)
