%{--include js lib for heatmap dynamically--}%
<r:require modules="data_upload"/>
<r:layoutResources disposition="defer"/>

<div id="analysisWidget">
    <h2>Variable Selection</h2>
    <form id="analysisForm">

		<div class="container">

			<div class="left" style="padding-right:10px;">
				<div style="padding-bottom: 10px;">
					<h3>Phenotips Address:</h3>
					<input type="text" id="phenoAddress" placeholder="http://localhost:10000"/>
				</div>
				
				<div style="padding-bottom:10px;">
					<h3>Phenotips Username:</h3>
					<input type="text" id="phenoUsername" placeholder="Admin"/>
				</div>
				
				<div style="padding-bottom:10px;">
					<h3>Phenotips Password:</h3>
					<input type="password" id="phenoPassword" placeholder="admin"/>
				</div>

				<input type="checkbox" onchange="dataUpload.togglePasswordDisplay(this);"/> Show password <br><br>
				<input type="button" value="Upload Data" onClick="dataUpload.submit_job(this.form);" class="runAnalysisBtn"/>
			</div>

			<div class="right">
				<div>
					<h3>Patient Upload List:</h3>
					<input type="text" id="patientIdTextBox" placeholder="Enter Patient Id"/>
					<input type="button" value="Add" onClick="dataUpload.manualAddPatientInfo();"/>
				</div>
	
				<div style="padding-top:10px; padding-bottom:10px; width:300px">
					<table id="patientIdTable" class="phenoimport-scrollable-table">
						<tbody>
						</tbody>
					</table>
				</div>

				<div>
					<input type="button" value="Get Patient Ids" onClick="dataUpload.getPhenoPatientList();" id="phDataFetcher"/>
					<input type="button" value="Select All" onClick="dataUpload.toggleSelectAll();"/>
					<input type="button" value="Remove" onClick="dataUpload.clearCheckedItems();"/>
				</div>
			</div>
		</div>
			
	</form>
</div>


