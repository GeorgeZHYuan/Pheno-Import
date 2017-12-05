# Pheno-Import
Upload [Phenotips data](https://phenotips.org/) to [tranSMART](http://transmartfoundation.org/).
* Fetches data using [Phenotips RESTFUL API](https://phenotips.org/DevGuide/API)
* Parses JSON response into tables using algorithms in `/src/Pheno_Parser.py`.
* Uploads data using [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).
* User interface in Analysis Jobs used to run the process.

This build is made for Linux OS.

# Setup
IMPORTANT: Make sure you have direct access to the tranSMART database.
1. Clone this project into a directory.
2. Check all variables in `conf/setup.config`.
   * Using your own version of [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).
     * Set `TM_DATALOADER_PATH` to the directory of your installation.
     * Create a `Config.groovy` file with `dataDir` set to `PHENOTIPS_HOME_DIRECTORY/import-data`. 
     * Set `TM_CONFIG_FILE_PATH` to the path of this `Config.groovy` file.
   * Using Pheno-Import's [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).
     * This setup is a general solution. We recommend the previous option. 
     * This will only work for postgres databases.
     * Make sure the username for `TRANSMART_DB_USR` is still available in database.
     * Make sure you have root privileges.
3. Run `configure.sh` once you have determined the correct settings.
4. Make sure tomcat has restarted. Manually restart it if did not.

# Running
**From Analysis Jobs**
1. Find the Job "Upload Phenotips Data" in the analysis jobs section.
2. Give the Phenotips website url and a set of valid credentials. (Needed to access the data)
3. Create a list of patients to upload in the table on the right.
4. Click upload data and refresh page for results. If any errors occur, no changes will be made.

**From Terminal** (only available from the installer side)
1. Open `pheno-import.sh`.
2. Fill in the correct variables for `upload_vars` and `patient_ids` (See `pheno-import.sh`). 
3. Run `pheno-import.sh`.
 
# General Debugging Tips
**Installer Side Only**
* Check the `Config.groovy` file for [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader). The Pheno-Import installation config file is in `conf/Config.groovy`.
  
* Check the upload variables in `src/upload_vars.py`.
  * These are the variables submitted at the start of the process.
  * This file is re-written for each upload. Changing values here do not do anything. 
  
* Check the `import-data` directory for the upload files and tables.
  * Check `clinical.*` for clinical data files. The `*.csv` file was not used but generated for easier viewing.
  * Check `{TOP_NODE}_{STUDY_NAME}_Mapping_File.txt` for column file.
  * All files in the `import-data` directory in are rewritten for each upload. 
    * To upload using these exact files, directly use [tMDataLoader](https://github.com/Clarivate-LSPS/tMDataLoader).

**Analysis Jobs Side**
* Check if the `get patient ids` button adds any patients to the table.
  * If the button doesn't work, the website url and credentials provided are invalid/un-authorized.
* Try copy-pasting the website url and credentials to access Phenotips to check the values.
* Go to the phenotips website and add `/rest/patients` behind the url. Check if patient id exists.
* This build does not support uploading to multiple studies at once. Make sure only one cohort is selected. 
