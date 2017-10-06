#!/bin/bash

source conf/vars
source ./loggit.sh

filename=$1
patients=()

# Aquires a list of patient IDs from "filename"
# This is the list of patients that the user wants to import
while IFS='' read -r line || [[ -n "$line" ]]; do	# Iterates through "filename" line by line until eof
    patients+=($line)								# Adds each line as new element to patients array
done < "$filename"

# Creates patient data tables according to patients ID in the patients array
./create_table.sh "${patients[@]}"

# loads data to transmart
$PH_IMPORT_HOME/import-data/Clinical-data/load_clinical.sh
