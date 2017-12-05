# Pheno-Import
Upload [Phenotips data](https://phenotips.org/) to [tranSMART](http://transmartfoundation.org/).
* Fetches data using [Phenotips RESTFUL API](https://phenotips.org/DevGuide/API)
* Creates Upload files through parsing HTTP responses.
* Uploads data to [tranSMART](http://transmartfoundation.org/) using [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).

This build is made for linux OS.

# Setup
1. Check all variables in `conf/setup.config`.
   * Using your own version of [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).
     * Set `TM_DATALOADER_PATH` to the directory of your own installation.
     * Create a `Config.groovy` file with the 'dataDir' set to PHENOTIPS_HOME_DIRECTORY/import-data. 
     * Set `TM_CONFIG_FILE_PATH` to the path of this `Config.groovy` file.
   * Using Pheno-Import's [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).
     * Make sure 'TRANSMART_DB_USR' username is still available in the database.
     * Make sure you have root-privileges.
2. Run `configure.sh` once you have determined the correct settings.

# Running
**From Analysis Jobs**
1. Find the Job "Upload Phenotips Data" in the analysis jobs section.
2. Give the Phenotips website url and a set of valid credentials. (Needed to access the data)
3. Create a list of patients to upload in the table on the right.
4. click upload data and refresh page for results. If anything went wrong, there wont be any changes.

**From terminal**

This option is only available for the installer
1. Open `pheno-import.sh`.
2. Fill in the correct variables for `upload_vars` and `patient_ids` (See `pheno-import.sh`). 
3. Run `pheno-import.sh`.
 
# General Debugging Tips
**Installer Side Only**

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

**Analysis Jobs Side**
* Check if the `get patient ids` button gives you a list of patients.
  * If you can't this means the website url and credentials you provided are invalid/un-authorized.
  * Try copy-pasting the website url into the browser and logging in. If this doesn't work, re-check these values.
  * Make sure only one cohort is being used at time when uploading data.
* Remember, re-uploading patients with no changes in data will not make any changes. Does not always mean failure.
* If some patients are missing, it means that their patients were not found.
