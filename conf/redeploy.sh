# location Variables
PH_HOME=$1
RDC_MODULES=$2
compile_location=$PH_HOME/AnalysisJob
edit_location=/var/lib/tomcat7/webapps
rmod_ctrl_location=/classes/com/recomdata/transmart/data/association
web_apps_location=/transmart/plugins/$RDC_MODULES
PAGE_NAME="Upload Phenotips Data"

# adding new files
sudo cp $compile_location/views/DataUpload.gsp $edit_location/transmart/WEB-INF/plugins/$RDC_MODULES/grails-app/views/plugin
sudo cp $compile_location/js/DataUpload.js $edit_location$web_apps_location/js/plugin
sudo cp $compile_location/css/rmodules.css $edit_location$web_apps_location/css
sudo cp $compile_location/RmodulesResources/RmodulesResources*.class $edit_location/transmart/WEB-INF/classes

# deploying war file
sudo rm -r $edit_location/phenoimport
sudo cp $compile_location/phenoimport.war $edit_location

# Restart tomcat7 to apply changes
sudo service tomcat7 restart

#register analysis job page
sudo -u postgres psql transmart -c "DELETE FROM searchapp.plugin_module WHERE name='$PAGE_NAME';" -t
res=$(echo "SELECT module_seq FROM searchapp.plugin_module ORDER BY module_seq desc limit 1;" | sudo -u postgres psql transmart -t)
max_module_seq=$(echo $res | xargs)
command="insert into searchapp.plugin_module(module_seq, plugin_seq, name, module_name, form_page, params) values ($max_module_seq + 1, 1, '$PAGE_NAME', 'dataUpload', 'DataUpload', '{}');"
echo "$command" |  sudo -u postgres psql transmart


