#!/bin/bash

#Assume data file has all required column labels, data will be append to it

#Software jq needs to be downloaded
#sudo apt-get install jq

a=1

#printf "\n" >> extracted_data.txt

echo -e "$a\t" >> extracted_data.txt

a=$(( $a + 1 ))

jq -r '.patient_name .first_name'  sample_data.JSON >> extracted_data.txt 
jq -r '.patient_name .last_name'  sample_data.JSON >> extracted_data.txt 

echo -e "\t" >> extracted_data.txt

sed ':a;N;$!ba;s/\n/ /g' extracted_data.txt





