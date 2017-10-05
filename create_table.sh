#!/bin/bash

. ./get-data.sh

arr = $1
for i in "${arr[@]}"
do
	local patient = $(getPatient ${arr[$i]})
	addPatient $patient
done

function addPatient {
	echo "Oooooohohohoho"
}


