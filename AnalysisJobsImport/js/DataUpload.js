/**
 * Register drag and drop.
 * Clear out all gobal variables and reset them to blank.
 */
function loadDataUploadView() {};


// constructor
var DataUploadView = function () {
    RmodulesView.call(this);
};


// inherit RmodulesView
DataUploadView.prototype = new RmodulesView();


// correct the pointer
DataUploadView.prototype.constructor = DataUploadView;


// submit analysis job
DataUploadView.prototype.submit_job = function (form) {
	// get formParams
    var formParams = this.get_form_params(form);

	// if formParams are submitable
	if (this.parametersAreValid(formParams)) {
        submitJob(formParams);
	}
};

// get form params
DataUploadView.prototype.get_form_params = function (form) {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');	
	var cohortInfo = this.getCohortInfo();
	var uploadPatients = [];
	
    for (var i = 0; i < checkboxes.length; i++) {
//      if (checkboxes[i].checked == true) {
        uploadPatients.push(table.rows[i].cells[0].innerHTML);
//      }
    }

	return {
		phenoImportLocation: "$HOME/Pheno-Import/pheno_import.sh",
		topNode: cohortInfo[0],
		studyName: cohortInfo[1],
		phenoAddress: this.getUrl(form.phenoAddress.value),
		phenoUsername: form.phenoUsername.value,
		phenoPassword: form.phenoPassword.value,
		patientIds: uploadPatients,
		jobType: 'DataUpload'
	}
};


// check if paramters are valid
DataUploadView.prototype.parametersAreValid = function(form_params) {
	var keys = [ 
		'phenoAddress', 
		'phenoUsername', 
		'phenoPassword',
		'patientIds'
	];

	for (var i = 0; i < keys.length-1; i++){
		if (form_params.hasOwnProperty(keys[i])){
			if (form_params[keys[i]] == null || form_params[keys[i]] == "") {
				alert("missing value in for: " + keys[i]);
				return false;
			}
		} else {
			alert("form missing parameters");
			return false;		
		}
	}
	
	if (form_params['patientIds'].length < 1) {
		alert("No patients to upload");
		return false;
	}

	return true;
};


// remove '/' from end of url
DataUploadView.prototype.getUrl = function (url) {
	if (url[url.length-1] == "/" && url[url.length-2] != "/"){
		url = url.slice(0, -1);
	}
	return url;
}


// removed checked items in patient table
DataUploadView.prototype.clearCheckedItems = function () {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');	
	
	for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked == true) {
		console.log("Removing: " + table.rows[i].cells[0].innerHTML);
        table.deleteRow(i);
		i -= 1;
      }
    }
};

// select or unselect all patients in patient table
DataUploadView.prototype.toggleSelectAll = function () {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');
	var selectState = true;	
    
	if (checkboxes[0].checked == true) {
		selectState = false;
	}
	for (var i = 0; i < checkboxes.length; i++) {
     	checkboxes[i].checked = selectState;
    }
}

// get topNode and studyName for study
DataUploadView.prototype.getCohortInfo = function () {
	var info = GLOBAL.CurrentSubsetQueries[1];
	var infoStart = info.search("<tooltip>\\\\");
	var infoEnd = info.search("\\\\</tooltip>");
	
	info = GLOBAL.CurrentSubsetQueries[1].slice(infoStart+10, infoEnd);
	var splitPos = info.search("\\\\");
	var topNode = info.slice(0, splitPos);
	var studyName = info.slice(splitPos+1, info.length);
	
	return [topNode, studyName];
};


// request for patient ids to show for user
DataUploadView.prototype.getPhenoPatientList = function () {
	document.getElementById("phDataFetcher").disabled = true;	
	var job = this;	
	var url = this.getUrl(document.getElementById('phenoAddress').value);
	var username = document.getElementById('phenoUsername').value;
	var password = document.getElementById('phenoPassword').value;
	var params = "url="+url+"&username="+username+"&password="+password;
	var servletAddress = "http://"+window.location.host+"/phenoimport/FetchPatientIds";
	var request = new XMLHttpRequest();
	
	request.open("GET", servletAddress+"?"+params, true);
	request.send();
 	request.onreadystatechange = function () {
        if (request.readyState == 4 && request.status == 200) {
		document.getElementById("phDataFetcher").disabled = false;
		var response = JSON.parse(request.responseText);
		for (var i = 0; i < response.length; i++) {
			job.addPatientInfo(response[i].name, response[i].id);
			console.log("Adding: " + response[i].name + ", "+ response[i].id);
		}
			
        } 
    }	
};

// add patient to table from user input
DataUploadView.prototype.manualAddPatientInfo = function () {
	var patientId = document.getElementById("patientIdTextBox").value;
	
	if (patientId != null || patientId != "") {
		this.addPatientInfo("Unknown", patientId);
	}
	
};

// add patient to table
DataUploadView.prototype.addPatientInfo = function (name, id) {
	var table = document.getElementById("patientIdTable");
	var row = table.insertRow(0);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);

    cell1.innerHTML = id;
    cell2.innerHTML = name;
	cell3.innerHTML = "<input type=\"checkbox\" class=\"UploadConf\"/>";
};


// hide or show password
DataUploadView.prototype.togglePasswordDisplay = function (checkbox){
	var pswdTextBox = document.getElementById('phenoPassword');
	
	if (checkbox.checked) {
		pswdTextBox.type = 'text';
	} else {
		pswdTextBox.type = 'password';
	}
}


// init heat map view instance
var dataUpload = new DataUploadView();
