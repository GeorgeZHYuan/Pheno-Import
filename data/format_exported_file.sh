sed 's/\"//g' data_clinical.tsv > data.tmp
python extract_data.py "Public_Studies" "TEST_STUDY" "column.tmp"
