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


// Edit ============================================
function validateEditForm() {
	if ($("#ename").val().trim() == "") {
		return "Insert Name.";
	}
	if ($("#enic").val().trim() == "") {
		return "Insert NIC.";
	}
	if ($("#eaddress").val().trim() == "") {
		return "Insert Address.";
	}
	if ($("#ezipcode").val().trim() == "") {
		return "Insert Zip Code.";
	}
	if ($("#eemail").val().trim() == "" || !emailValidation.test($("#email").val())){
		return "Insert Valide Email";
	}
	if ($("#ephone").val().trim() == "" || !phoneValidation.test($("#phone").val())) {
		return "Insert Valied Contact Number.";
	}
	
	return true;
}

$(document).on("click", "#esave", function(event) {
	// Clear alerts---------------------
	$("#editSuccess").text("");
	$("#editSuccess").hide();
	$("#editError").text("");
	$("#editError").hide();

	// Form validation-------------------
	var status = validateEditForm();

	if (status != true) {
		$("#editError").text(status);
		$("#editError").show();
		return;
	}

	$.ajax({
		url : "UserServlet",
		type : "PUT",
		data : $("#editformUser").serialize(),
		dataType : "text",
		complete : function(response, status) {
			onItemEditComplete(response.responseText, status);
		}
	});
});


function onItemEditComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#editSuccess").text("Successfully saved.");
			$("#editSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#editError").text(resultSet.data);
			$("#editError").show();
		}	
	} else if (status == "error") {
		$("#editError").text("Error while saving.");
		$("#editError").show();
	} else {
		$("#editError").text("Unknown error while saving..");
		$("#editError").show();
	}
	$("#hidItemIDSave").val("");
}


//delete================================================================
$(document).ready(function() {
	$.ajax({
		url: "UserServlet",
		type: "DELETE",
		data : $("#data").serialize(),
		cache: false,
		complete : function(response, status) {
			onItemEditComplete(response.responseText, status);
		}
		//success: function(dataResult){
			//$('#data : $("#editformUser").serialize(),').html(dataResult); 
			//onItemSaveComplete(response.responseText, status);
		//}
	});
	$(document).on("click", ".delete", function() { 
		var $ele = $(this).parent().parent();
		$.ajax({
			url: "UserServlet",
			type: "DELETE",
			cache: false,
			data:{
				id: $(this).attr("id")
			},
			success: function(dataResult){
				var dataResult = JSON.parse(dataResult);
				if(dataResult.statusCode==name){
					$ele.fadeOut().remove();
				}
			}
		});
	});
});




