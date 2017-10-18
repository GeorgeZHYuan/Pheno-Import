ADJ_COLUMN_FILE=$PH_IMPORT_HOME/tmp/adjusted_column.tmp
ADJ_CLINICAL_FILE=$PH_IMPORT_HOME/tmp/adjusted_clinical.tmp
TRANSMART_EXPORT_FILE=$PH_IMPORT_HOME/tmp/export_file.tmp

sed 's/\"//g' data_clinical.tsv > $TRANSMART_EXPORT_FILE

if [ -e $ADJ_COLUMN_FILE ]; then 
	rm $ADJ_COLUMN_FILE 
fi;
if [ -e $ADJ_CLINICAL_FILE ]; then 
	rm $ADJ_CLINICAL_FILE 
fi;

touch $ADJ_COLUMN_FILE
cp $TRANSMART_EXPORT_FILE $ADJ_CLINICAL_FILE

python create_clinical_column_file.py "Public_Studies" "TEST_STUDY" $ADJ_COLUMN_FILE $TRANSMART_EXPORT_FILE
python create_clinical_file.py "Public_Studies" "TEST_STUDY" $ADJ_CLINICAL_FILE $CLINICAL_LABELS
