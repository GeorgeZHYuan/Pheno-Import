# Analysis Job Variable
variables=("$@")
TM_TOP_NODE='Public Studies'
TM_STUDY_NAME='Phenotips'
TM_STUDY_ID='PHENOTEST'
PH_HOST='localhost'
PH_PORT='10000'
PH_USER='Admin'
PH_PWD='admin'

# Setup python variables
echo "# Setup python global vars
import sys
from Data_Types import *

# Pheno-Import Paths
PH_HOME='$PH_HOME'

# Transmart Variables
TM = Transmart_Study()
TM.TOP_NODE = '$TM_TOP_NODE'
TM.STUDY_NAME = '$TM_STUDY_NAME'
TM.STUDY_ID = '$TM_STUDY_ID'

# Phenotips Variables
PH = Pheno_Settings()
PH.ADDRESS = '$PH_HOST:$PH_PORT'
PH.USER = '$PH_USER'
PH.PWD = '$PH_PWD'" > $PH_HOME/src/global_vars.py

# Setup tMDataLoader config files
echo "dataDir = '$PH_HOME/import-data'
db.hostname = '$PSQL_HOST'
db.port = '$PSQL_PORT'
db.username = '$acc'
db.password = '$pwd'
db.jdbcConnectionString = 'jdbc:postgresql://$PSQL_HOST:$PSQL_PORT/transmart'
db.jdbcDriver = 'org.postgresql.Driver'
db.sql.storedProcedureSyntax = 'PostgreSQL'
db.sid = 'xe'" > $PH_HOME/conf/Config.groovy


