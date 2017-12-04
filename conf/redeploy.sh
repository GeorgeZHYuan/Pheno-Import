# Location Variables
compile_location=$HOME/Pheno-Import/conf/AnalysisJobsImport
edit_location=/var/lib/tomcat7/webapps


# Adding new files
if [ ! -d $edit_location/transmart/plugins/rdc-rmodules-16.2/Rscripts/DataUpload ]; then
	mkdir $edit_location/transmart/plugins/rdc-rmodules-16.2/Rscripts/DataUpload
fi

sudo cp $compile_location/DataUploadController/DataUploadController*.class $edit_location/transmart/WEB-INF$rmod_ctrl_location
sudo cp $compile_location/DataUpload/DataUpload*.class $edit_location/transmart/WEB-INF/classes/jobs

sudo cp $compile_location/Rscripts/DataUpload.R $edit_location/transmart/plugins/rdc-rmodules-16.2/Rscripts/DataUpload
sudo cp $compile_location/views/DataUpload.gsp $edit_location/transmart/WEB-INF/plugins/rdc-rmodules-16.2/grails-app/views/plugin
sudo cp $compile_location/views/_dataUpload_out.gsp $edit_location/transmart/WEB-INF/plugins/rdc-rmodules-16.2/grails-app/views/plugin
sudo cp $compile_location/js/DataUpload.js $edit_location/transmart/plugins/rdc-rmodules-16.2/js/plugin
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
# ********* To avoid this.									  *********
# *********                                                   *********
# *********************************************************************
# *********************************************************************

# Directly inserting editted files
sudo cp $compile_location/RModulesController/RModulesController*.class $edit_location/transmart/WEB-INF$rmod_ctrl_location
sudo cp $compile_location/RmodulesResources/RmodulesResources*.class $edit_location/transmart/WEB-INF/classes
sudo cp $compile_location/grails.xml $edit_location/transmart/WEB-INF
sudo cp $compile_location/css/rmodules.css $edit_location/transmart/plugins/rdc-rmodules-16.2/css


# Restart tomcat7 to apply changes
sudo service tomcat7 restart




