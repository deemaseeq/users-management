$(document).on("submit", "#addGroup", function(event) {
	var $form = $(this);

	$.post($form.attr("action"), $form.serialize(), function(response) {
		response = response.trim();
		if (response === 'Succesful addition') {
			location.reload();
		} else {
			alert(response);
		}

	});

	event.preventDefault(); // Important! Prevents submitting the form.
});

function groupDelete(groupRow) {
	var groupName = groupRow.cells[1].innerHTML;
	var groupId = groupRow.cells[0].innerHTML;

	var sureToDelete = confirm('Are you sure you want to delete group '
			+ groupName + ' from database? This action can not be undone.');

	if (sureToDelete) {
		$.post("group/delete", {
			id : groupId
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

function groupEdit(deptRow) {
	var groupName = deptRow.cells[1].innerHTML;
	var groupId = deptRow.cells[0].innerHTML;

	document.getElementById('edit-group-message').textContent = 'You are going to edit data of group with id '
			+ groupId + ' and name ' + groupName;

	document.getElementById('edit-group-id').value = groupId;
	document.getElementById('edit-group-name').value = groupName;

	document.getElementById('edit-group-modal').style.display = 'block';
}

$(document).on("submit", "#editGroup", function(event) {
	var $form = $(this);

	$.post($form.attr("action"), $form.serialize(), function(response) {
		response = response.trim();
		if (response === 'Succesful editing') {
			location.reload();
		} else {
			alert(response);
		}

	});

	event.preventDefault(); // Important! Prevents submitting the form.
});