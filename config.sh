source conf/setup.config
PH_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get update
sudo apt-get install python-pip
sudo pip install requests

# setup phenotips psql user
sudo -u postgres createuser $TRANSMART_DB_USR -s
sudo -u postgres psql -c "ALTER USER $TRANSMART_DB_USR WITH PASSWORD '$TRANSMART_DB_PWD';"
if [ ! -f ~/.pgpass ]; then
	touch ~/.pgpass
	chmod 0600 ~/.pgpass
fi;

# Local installation of tMDataLoader
if [[ $TM_DATALOADER_PATH == 'install local version' ]]; then
	TM_DATALOADER_PATH=$PH_HOME/tMDataLoader
	# Configure tMDataLoader Settings
	git clone https://github.com/Clarivate-LSPS/tMDataLoader.git
	cd tMDataLoader
	rm Config.groovy
	./gradlew deployJar


	ADDRESS=$TRANSMART_DB_HOST:$TRANSMART_DB_PORT
	echo "$ADDRESS:transmart:$TRANSMART_DB_USR:$TRANSMART_DB_PWD" >> ~/.pgpass

	# setup sql scripts for tMDataLoader
	cd sql/postgres
	psql -d transmart -U $TRANSMART_DB_USR -f migrations.sql -h $TRANSMART_DB_HOST
	psql -d transmart -U $TRANSMART_DB_USR -f permissions.sql -h $TRANSMART_DB_HOST
	psql -d transmart -U $TRANSMART_DB_USR -f procedures.sql -h $TRANSMART_DB_HOST

	# Setup tMDataLoader config file
	TM_CONFIG_FILE_PATH=$PH_HOME/conf/Config.groovy
	echo "dataDir = '$PH_HOME/import-data'
	db.hostname = '$TRANSMART_DB_HOST'
	db.port = '$TRANSMART_DB_PORT'
	db.username = '$TRANSMART_DB_USR'
	db.password = '$TRANSMART_DB_PWD'
	db.jdbcConnectionString = 'jdbc:postgresql://$ADDRESS/transmart'
	db.jdbcDriver = 'org.postgresql.Driver'
	db.sql.storedProcedureSyntax = 'PostgreSQL'
	db.sid = 'xe'" > $TM_CONFIG_FILE_PATH
fi;

# Setup Pheno-Import settings
echo "PH_HOME=$PH_HOME 
TM_DATALOADER_PATH=$TM_DATALOADER_PATH
TM_CONFIG_FILE_PATH=$TM_CONFIG_FILE_PATH 
TRANSMART_DB_USR=$TRANSMART_DB_USR
TRANSMART_DB_HOST=$TRANSMART_DB_HOST" > $HOME/.Pheno_Settings.config

# Setup analysis jobs
scriptPath=$PH_HOME/pheno_import.sh
number=$(awk '/phenoImportLocation/{ print NR; exit }' '/home/georgeyuan/Pheno-Import/AnalysisJobsImport/js/DataUpload.js')
replacement="		phenoImportLocation: \""${scriptPath//\//\\/}\",
sed -i "${number}s/.*/$replacement/" $PH_HOME/AnalysisJobsImport/js/DataUpload.js
bash $PH_HOME/conf/redeploy.sh $PH_HOME


