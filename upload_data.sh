#!/bin/bash

# loads data to transmart
echo "Calling kettle script..."
$PH_IMPORT_HOME/import-data/Clinical-data/load_clinical.sh
