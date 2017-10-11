#!/bin/bash

# Initialize
source conf/vars
source logs/loggit.sh
. ./get_data.sh

patient_ids=()
patient_ids+=('P0000001')
patient_ids+=('P0000002')
patient_ids+=('P0000003')
patient_ids+=('P0000004')

# Get the phenotips data
patient_dataset=($(get_patient_data "${patient_ids[@]}"))

# Create patient data table for new study
./upload_new_study.sh "${patient_dataset[@]}"

