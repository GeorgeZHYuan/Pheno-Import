#!/bin/bash

source vars

i=0
while IFS='' read -r line || [[ -n "$line" ]]; do
    patients[$i]=$line
	i+=1
done < "$1"

./create_table.sh $patients

#$PH_IMPORT_HOME/import-data/Clinical-data/load_clincial.sh

