# Pheno-Import
* Load phenotips data to transmart
* Fetches data from phenotips using REST API,
* Creates Upload files through parsing HTTP responses from phenotips
* Uploads data to transmart using tMDataLoader: `https://github.com/Clarivate-LSPS/tMDataLoader`

# Setup
1. Make sure all the variables are setup correctly in `conf/setup.config` 
2. Run `./configure.sh`

# Running
**From terminal**
1. Open `pheno-import.sh`
2. Mannually fill in the variables such `upload_vars` and `patient_ids`. 
2. Execute pheno-import in terminal

**From Analysis Jobs**
1. Not yet availble...
 
# General Debugging Tips
1. Confirm tMDataLoader variables in `conf/setup.config` are correct
2. Check if the upload variables are correct in `src/upload_vars.py`
3. Dive into `import-data` directory and check the upload data, then directly use tMDataLoader to upload the data using the fixed files.
   Note: Any errors here were probably from the JSON parsing scripts within Pheno-Import. 
