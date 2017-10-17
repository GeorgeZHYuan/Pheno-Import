#!/bin/bash

python extract_data.py

TEXT=("$@")

python extract_data.py $TEXT

