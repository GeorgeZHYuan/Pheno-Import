sed 's/\"//g' data/data_clinical.tsv > data/export_file.tmp

if [ -e column.tmp ]; then
	rm column.tmp
fi;
touch column.tmp

python create_column_file.py "Public_Studies" "TEST_STUDY" "column.tmp"
#python create_column_file.py "Public_Studies" "PHENO_TEST" "column.tmp"


