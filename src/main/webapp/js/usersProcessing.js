/**
 * An event that will be called on submitting form to add user.
 */
$(document).on("submit", "#addUser", function(event) {
	var $form = $(this);

	var date = document.getElementById('add-user-date').value;

	if (isValidDate(date)) {

		var username = $("#add-user-username").val();
		var userPassword = $("#add-user-password").val();
		var userFirstName = $("#add-user-first-name").val();
		var userLastName = $("#add-user-last-name").val();
		var userBirthDate = $("#add-user-date").val();
		var userGroups = "";

		var checkBoxes = document.getElementById('add-user-checkboxes');

		for (var i = 0; i < checkBoxes.children.length; i++) {
			if (checkBoxes.children[i].children[1].checked) {
				userGroups += checkBoxes.children[i].firstElementChild.value;
				if(i != (checkBoxes.children.length - 1)){
					userGroups += ",";
				}
			}
		}

		var userData = {
				username : username,
				password : userPassword,
				firstName : userFirstName,
				lastName : userLastName,
				birthDate : userBirthDate,
				groups : userGroups
		};

		$.post("user/add", userData, function(response) {
			response = response.trim();
			if (response === 'Succesful addition') {
				location.reload();
			} else {
				alert(response);
			}

		});
	} else {
		document.getElementById('add-user-date-error').innerHTML = "Please enter date in format YYYY-MM-DD";
	}

	event.preventDefault(); // Important! Prevents submitting the form!

});


/**
 * A function to clear validation messages and show user addition form.
 */
function userAdd() {
	document.getElementById('add-user-date-error').innerHTML = "";
	document.getElementById('add-user-modal').style.display = 'block';
}

function userDelete(userRow) {
	var username = userRow.cells[1].innerHTML;
	var userId = userRow.cells[0].innerHTML;

	var sureToDelete = confirm('Are you sure you want to delete employee '
			+ username + ' from database? This action can not be undone.');

	if (sureToDelete) {
		$.post("user/delete", {
			id : userId
		}, function(response) {
			response = response.trim();
			if (response === 'Succesful delete') {
				location.reload();
			} else {
				alert(response);
			}
		});
	}
}

/**
 * A function to clear validation messages, fill the form by content specific to
 * every user and show user editing form.
 * 
 * @param userRow
 */
function userEdit(userRow) {
	var userId = userRow.cells[0].innerHTML;
	var username = userRow.cells[1].innerHTML;
	var userPassword = userRow.cells[2].innerHTML;
	var userFirstName = userRow.cells[3].innerHTML;
	var userLastName = userRow.cells[4].innerHTML;
	var userBirthDate = userRow.cells[5].innerHTML;
	
	var checkBoxes = document.getElementById('edit-user-checkboxes');
	
	for (var i = 0; i < checkBoxes.children.length; i++) {
		checkBoxes.children[i].children[1].checked = false;
	}

	document.getElementById('edit-user-message').textContent = 'You are going to edit data of user with id '
			+ userId + ' and username ' + username;

	$("#edit-user-id").val(userId);
	$("#edit-user-username").val(username);
	$("#edit-user-password").val(userPassword);
	$("#edit-user-first-name").val(userFirstName);
	$("#edit-user-last-name").val(userLastName);
	$("#edit-user-date").val(userBirthDate);

	document.getElementById('edit-user-date-error').innerHTML = "";

	for (var i = 0; i < checkBoxes.children.length; i++) {
		var groupName = checkBoxes.children[i].children[2].innerHTML;

		if (userRow.nextElementSibling.cells[1].innerHTML.indexOf(groupName) != -1) {
			checkBoxes.children[i].children[1].checked = true;
		}
	}

	document.getElementById('edit-user-modal').style.display = 'block';
}

/**
 * An event that will be called on submitting form to edit user.
 */
$(document).on("submit", "#editUser", function(event) {
	var $form = $(this);

	var date = userBirthDate = $("#edit-user-date").val();

	if (isValidDate(userBirthDate)) {

		var userId = $("#edit-user-id").val();
		var username = $("#edit-user-username").val();
		var userPassword = $("#edit-user-password").val();
		var userFirstName = $("#edit-user-first-name").val();
		var userLastName = $("#edit-user-last-name").val();
		var userGroups = "";

		var checkBoxes = document.getElementById('edit-user-checkboxes');

		for (var i = 0; i < checkBoxes.children.length; i++) {
			if (checkBoxes.children[i].children[1].checked) {
				userGroups += checkBoxes.children[i].firstElementChild.value;
				if(i != (checkBoxes.children.length - 1)){
					userGroups += ",";
				}
			}
		}

		var userData = {
				id: userId,
				username : username,
				password : userPassword,
				firstName : userFirstName,
				lastName : userLastName,
				birthDate : userBirthDate,
				groups : userGroups
		};

		$.post("user/edit", userData, function(response) {
			response = response.trim();
			if (response === 'Succesful editing') {
				location.reload();
			} else {
				alert(response);
			}

		});
	} else {
		document.getElementById('edit-user-date-error').innerHTML = "Please enter date in format YYYY-MM-DD";
	}

	event.preventDefault(); // Important! Prevents submitting the form!
	
});

/**
 * A function that checks if date is in format "YYYY-MM-DD".
 * 
 * @param dateString
 */
function isValidDate(dateString) {
	var regEx = /^\d{4}-\d{2}-\d{2}$/;

	if (!dateString.match(regEx))
		return false; // Invalid format

	var d;

	if (!((d = new Date(dateString)) | 0))
		return false; // Invalid date (or this could be epoch)

	return d.toISOString().slice(0, 10) === dateString;
}

/**
 * A function to show groups which user belongs by showing special row of a
 * table. That row is hidden by default.
 * 
 * @param userRow
 */
function showGroups(userRow) {
	var groups = userRow.nextElementSibling;

	if (groups.classList.contains("w3-hide")) {
		groups.classList.remove("w3-hide");
	} else {
		groups.classList.add("w3-hide");
	}
}
