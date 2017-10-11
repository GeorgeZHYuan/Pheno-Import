#!/bin/bash

patients=("$@")

# creates clinical file
./create_new_study_clinical_file.sh "${patients[@]}"

# loads data to transmart
$PH_IMPORT_HOME/import-data/Clinical-data/load_clinical.sh
