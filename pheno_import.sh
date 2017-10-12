#!/bin/bash

source conf/vars
source logs/loggit.sh

patients=()

# Aquires a list of patient IDs from "filename"
# This is the list of patients that the user wants to import
while IFS='' read -r line || [[ -n "$line" ]]; do	# Iterates through "filename" line by line until eof
    patients+=($line)								# Adds each line as new element to patients array
done < "$PATIENT_ID_LIST"

# Creates patient data tables according to patients ID in the patients array
./upload_new_study.sh "${patients[@]}"

# loads data to transmart
$PH_IMPORT_HOME/import-data/Clinical-data/load_clinical.sh
