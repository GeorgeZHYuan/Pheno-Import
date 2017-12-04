//console.log("CONNECTED TO JAVASCRIPT BABY @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

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
	console.log(formParams);

	// if formParams are submitable
	if (this.parameters_are_valid(formParams)) {
        submitJob(formParams);
	}
};


// get form params
DataUploadView.prototype.get_form_params = function (form) {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');	

	var cohortInfo = this.get_cohort_info();
	var uploadPatients = [];
	
    for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked == true) {
		console.log("adding item: " + table.rows[i].cells[0].innerHTML);
        uploadPatients.push(table.rows[i].cells[0].innerHTML);
      }
    }
	console.log("checkbox rows: " + checkboxes.length);
	console.log("table: " + table.rows.length);

	return {
		topNode: cohortInfo[0],
		studyName: cohortInfo[1],
		phenoAddress: form.phenoAddress.value,
		phenoUsername: form.phenoUsername.value,
		phenoPassword: form.phenoPassword.value,
		patientIds: uploadPatients,
		jobType: 'DataUpload'
	}
};

DataUploadView.prototype.clear_unchecked_items = function () {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');	
	for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].checked == false) {
		console.log("deleting item: " + table.rows[i].cells[0].innerHTML);
        table.deleteRow(i);
		i -= 1;
      }
    }
};

DataUploadView.prototype.clear_all_items = function () {
	var table = document.getElementById("patientIdTable");
	var checkboxes = document.getElementsByClassName('UploadConf');	
	while (checkboxes.length != 0) {
        table.deleteRow(0);
    }
}

// get topNode and studyName
DataUploadView.prototype.get_cohort_info = function () {
	console.log(GLOBAL)
	var info = GLOBAL.CurrentSubsetQueries[1];
	console.log(info);

	var infoStart = info.search("<tooltip>\\\\");
	var infoEnd = info.search("\\\\</tooltip>");
	info = GLOBAL.CurrentSubsetQueries[1].slice(infoStart+10, infoEnd);

	var splitPos = info.search("\\\\");

	var topNode = info.slice(0, splitPos);
	var studyName = info.slice(splitPos+1, info.length);
	
	console.log(topNode);
	console.log(studyName);
	return [topNode, studyName];
};


// request for patient idsto show for user
DataUploadView.prototype.get_pheno_patient_list = function () {
	var job = this;	
	var url = document.getElementById('phenoAddress').value;
	var username = document.getElementById('phenoUsername').value;
	var password = document.getElementById('phenoPassword').value;

	var params = "url="+url+"&username="+username+"&password="+password;
	console.log(params);

	var servletAddress = "http://"+window.location.host+"/phenoimport/FetchPatientIds";

	console.log("\""+servletAddress+"\"");
	var request = new XMLHttpRequest();
	request.open("GET", servletAddress+"?"+params, true);
	request.send();

 	request.onreadystatechange = function () {
        if (request.readyState == 4 && request.status == 200) {
			var response = JSON.parse(request.responseText);
			job.add_patient_info(response.name, response.id, true);
			console.log(response);
        } 
    }	
};

// adds patient to table
DataUploadView.prototype.manual_add_patient_info = function () {
	
	var patientId = document.getElementById("patientIdTextBox").value;
	if (patientId != null || patientId != "") {
		this.add_patient_info("Unknown", patientId, true);
	}
	
};

// adds patient to upload table
DataUploadView.prototype.add_patient_info = function (name, id, include) {
	var table = document.getElementById("patientIdTable");
	var row = table.insertRow(0);

    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);

    cell1.innerHTML = id;
    cell2.innerHTML = name;
	cell3.innerHTML = "<input type=\"checkbox\" checked=\""+include+"\"class=\"UploadConf\"/>";
};


// hide or show the password
DataUploadView.prototype.togglePasswordDisplay = function (checkbox){
	console.log(checkbox.checked);
	var pswdTextBox = document.getElementById('phenoPassword');
	if (checkbox.checked) {
		pswdTextBox.type = 'text';
	} else {
		pswdTextBox.type = 'password';
	}
}


// check if paramters are valid
DataUploadView.prototype.parameters_are_valid = function(form_params) {
	var keys = [ 
		'phenoAddress', 
		'phenoUsername', 
		'phenoPassword',
		'patientIds'
	];

	console.log("keys length: " + keys.length);
	for (var i = 0; i < keys.length; i++){
		console.log("key: " + keys[i]);
		if (form_params.hasOwnProperty(keys[i])){
			if (form_params[keys[i]] == null) {
				console.log("missing value in for: " + keys[i]);
				return false;
			}
		} else {
			console.log("form missing parameters");
			return false;		
		}
	}
	return true;
};

// init heat map view instance
var dataUpload = new DataUploadView();
