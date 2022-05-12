$(document).ready(function(){
	alert("Page Loaded");
});

//validations================================================================================================================================
var emailValidation = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var phoneValidation = /^\d{10}$/;

function validateItemForm() {
	if ($("#name").val().trim() == "") {
		return "Insert Name.";
	}
	if ($("#nic").val().trim() == "") {
		return "Insert NIC.";
	}
	if ($("#address").val().trim() == "") {
		return "Insert Address.";
	}
	if ($("#zipcode").val().trim() == "") {
		return "Insert Zip Code.";
	}
	if ($("#email").val().trim() == "" || !emailValidation.test($("#email").val())){
		return "Insert Valide Email";
	}
	if ($("#phone").val().trim() == "" || !phoneValidation.test($("#phone").val())) {
		return "Insert Valied Contact Number.";
	}
	
	return true;
}


// SAVE ============================================
$(document).on("click", "#addUser", function(event) { 
	// Clear alerts---------------------
	$("#alertSuccess").text("");
	$("#alertSuccess").hide();
	$("#alertError").text("");
	$("#alertError").hide(); 
		
		// Form validation-------------------
		var status = validateItemForm(); if (status != true) {
			$("#alertError").text(status);
			$("#alertError").show();
				return;
		} $.ajax({
				url : "UserServlet",
				type : "post",
				data : $("#addformUser").serialize(),
				dataType : "text",
				complete : function(response, status) {
				onItemSaveComplete(response.responseText, status);
			}
		});
});

function onItemSaveComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while saving.");
		$("#alertError").show();
	} else {	
		$("#alertError").text("Unknown error while saving..");
		$("#alertError").show();
	}
	$("#hidItemIDSave").val("");
	$("#formItem")[0].reset();
}

