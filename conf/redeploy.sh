# Location Variables
PH_HOME=$1
compile_location=$PH_HOME/AnalysisJobsImport
edit_location=/var/lib/tomcat7/webapps
rmod_ctrl_location=/classes/com/recomdata/transmart/data/association
web_apps_location=/transmart/plugins/rdc-rmodules-16.2

# Adding new files
sudo mkdir $edit_location$web_apps_location/Rscripts/DataUpload

sudo cp $compile_location/DataUploadController/DataUploadController*.class $edit_location/transmart/WEB-INF$rmod_ctrl_location
sudo cp $compile_location/DataUpload/DataUpload*.class $edit_location/transmart/WEB-INF/classes/jobs

sudo cp $compile_location/Rscripts/DataUpload.R $edit_location$web_apps_location/Rscripts/DataUpload
sudo cp $compile_location/views/DataUpload.gsp $edit_location/transmart/WEB-INF/plugins/rdc-rmodules-16.2/grails-app/views/plugin
sudo cp $compile_location/views/_dataUpload_out.gsp $edit_location/transmart/WEB-INF/plugins/rdc-rmodules-16.2/grails-app/views/plugin
sudo cp $compile_location/js/DataUpload.js $edit_location$web_apps_location/js/plugin

sudo rm -r $edit_location/phenoimport
sudo cp $compile_location/phenoimport.war $edit_location


# *********************************************************************
# *********                     WARNING                       ********* 
# *********************************************************************
# *********                                                   *********
# ********* Any additional changes to the transmart war file  ********* 
# ********* after the original installation could be erased   ********* 
# ********* if choosing to use this direct insertion method.  *********
# *********                                                   *********
# ********* Check the insert as analysis job option section   *********
# ********* To avoid this.				      *********
# *********                                                   *********
# *********************************************************************
# *********************************************************************
# Directly inserting editted files
sudo cp $compile_location/RModulesController/RModulesController*.class $edit_location/transmart/WEB-INF$rmod_ctrl_location
sudo cp $compile_location/RmodulesResources/RmodulesResources*.class $edit_location/transmart/WEB-INF/classes
sudo cp $compile_location/grails.xml $edit_location/transmart/WEB-INF
sudo cp $compile_location/css/rmodules.css $edit_location$web_apps_location/css


# Restart tomcat7 to apply changes
sudo service tomcat7 restart


#register analysis job page
res=$(echo "SELECT module_seq FROM searchapp.plugin_module ORDER BY module_seq desc limit 1;" | sudo -u postgres psql transmart -t)
number=$(echo $res | xargs)
command="insert into searchapp.plugin_module(module_seq, plugin_seq, name, module_name, form_page, params) values ($number + 1, 1, 'Upload Phenotips Data', 'dataUpload', 'DataUpload', '{}');"
echo "$command" |  sudo -u postgres psql transmart


