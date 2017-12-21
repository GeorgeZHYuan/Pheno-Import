# setup variables
source conf/setup.config
PH_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ADDRESS=$TRANSMART_DB_HOST:$TRANSMART_DB_PORT

# setup python requirements
sudo apt-get update
sudo apt-get install python-pip
sudo pip install requests


# setup import-data folder
mkdir $PH_HOME/import-data
sudo chown -R $USER:tomcat7 $PH_HOME/*


# setup phenotips psql user
sudo -u postgres createuser $TRANSMART_DB_USR -s
sudo -u postgres psql -c "ALTER USER $TRANSMART_DB_USR WITH PASSWORD '$TRANSMART_DB_PWD';"

if [ ! -f $HOME/.pgpass ]; then
	touch $HOME/.pgpass
	chmod 0600 $HOME/.pgpass
fi;
echo "$ADDRESS:transmart:$TRANSMART_DB_USR:$TRANSMART_DB_PWD" >> $HOME/.pgpass

if [ ! -f $TOMCAT_HOME/.pgpass ]; then
	sudo touch $TOMCAT_HOME/.pgpass
	sudo chmod 0600 $TOMCAT_HOME/.pgpass
	sudo chown tomcat7:tomcat7 $TOMCAT_HOME/.pgpass
fi;
sudo chown $USER: $TOMCAT_HOME/.pgpass
sudo echo "$ADDRESS:transmart:$TRANSMART_DB_USR:$TRANSMART_DB_PWD" >> $TOMCAT_HOME/.pgpass
sudo chown tomcat7: $TOMCAT_HOME/.pgpass


# setup analysis jobs UI
compile_location=$PH_HOME/AnalysisJob
edit_location=/var/lib/tomcat7/webapps
rmod_ctrl_location=/classes/com/recomdata/transmart/data/association
web_apps_location=/transmart/plugins/$RMODULES_VERSION

sudo cp $compile_location/views/DataUpload.gsp $edit_location/transmart/WEB-INF/plugins/$RMODULES_VERSION/grails-app/views/plugin
sudo cp $compile_location/js/DataUpload.js $edit_location$web_apps_location/js/plugin
sudo cp $compile_location/css/rmodules.css $edit_location$web_apps_location/css
sudo cp $compile_location/RmodulesResources/RmodulesResources*.class $edit_location/transmart/WEB-INF/classes


# deploying phenoimport war file
sudo rm -r $edit_location/phenoimport
sudo cp $compile_location/phenoimport.war $edit_location


#register analysis job page
PAGE_NAME="Upload Phenotips Data"
sudo -u postgres psql transmart -c "DELETE FROM searchapp.plugin_module WHERE name='$PAGE_NAME';" -t
res=$(echo "SELECT module_seq FROM searchapp.plugin_module ORDER BY module_seq desc limit 1;" | sudo -u postgres psql transmart -t)
max_module_seq=$(echo $res | xargs)
command="insert into searchapp.plugin_module(module_seq, plugin_seq, name, module_name, form_page, params) values ($max_module_seq + 1, 1, '$PAGE_NAME', 'dataUpload', 'DataUpload', '{}');"
echo "$command" |  sudo -u postgres psql transmart

# setup tMDataLoader
if [[ $TM_DATALOADER_PATH == 'install local version' ]]; then
	TM_DATALOADER_PATH=$PH_HOME/tMDataLoader

	# Configure tMDataLoader Settings
	git clone https://github.com/Clarivate-LSPS/tMDataLoader.git
	cd tMDataLoader
	rm Config.groovy
	./gradlew deployJar

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


# saving pheno-import variables
echo "PH_HOME=$PH_HOME 
TM_DATALOADER_PATH=$TM_DATALOADER_PATH
TM_CONFIG_FILE_PATH=$TM_CONFIG_FILE_PATH 
TRANSMART_DB_USR=$TRANSMART_DB_USR
TRANSMART_DB_HOST=$TRANSMART_DB_HOST" > $HOME/.pheno_settings.config

sudo cp $HOME/.pheno_settings.config $TOMCAT_HOME
sudo chown tomcat7:tomcat7 $TOMCAT_HOME/.pheno_settings.config


# Restart tomcat7 to apply changes
sudo service tomcat7 restart
