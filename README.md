# Pheno-Import
Upload [Phenotips data](https://phenotips.org/) to [tranSMART](http://transmartfoundation.org/).
* Fetches data using [Phenotips RESTFUL API](https://phenotips.org/DevGuide/API)
* Creates Upload files through parsing HTTP responses.
* Uploads data to [tranSMART](http://transmartfoundation.org/) using [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).

Compatible with linux OS and [PostgreSQL](https://www.postgresql.org/) tranSMART databases.

# Setup
1. Make sure all the variables are setup correctly in `conf/setup.config` 
2. Run `configure.sh`

# Running
**From terminal**
1. Open `pheno-import.sh`.
2. Fill in the correct variables for `upload_vars` and `patient_ids`.
3. Run `pheno-import`.

**From Analysis Jobs**
1. Not yet availble...
 
# General Debugging Tips
* Check the variables for [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader) in:
  * `conf/setup.config`
  * `conf/Config.groovy`
  
* Check the upload variables in `src/upload_vars.py`.
  * This file is re-written for each upload. Changing values here do not do anything. 
  * Double check the varibles you submitted at the start of the process.
  
* Dive into the `import-data` directory and check the upload files.
  * Check `clinical.csv` for clinical data file.
  * Check `{TOP_NODE}_{STUDY_NAME}_Mapping_File.txt` for column file.
  * These files are rewritten for each upload. To apply any changes, directly use [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader) with these files.
