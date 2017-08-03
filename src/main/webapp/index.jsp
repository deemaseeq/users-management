<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.dmitry.database.HibernateInteraction"%>

<!DOCTYPE html>
<html>
<head>
<title>Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="lib/w3css/w3.css">
<link rel="stylesheet" href="style.css" type="text/css" />
<link rel="stylesheet" href="lib/font-awesome/css/font-awesome.min.css" />
<link rel="stylesheet" href="lib/bootstrap/bootstrap.min.css" />

</head>

<body>

	<jsp:scriptlet>pageContext.setAttribute("users", HibernateInteraction.getUsers());
			pageContext.setAttribute("groups", HibernateInteraction.getGroups());</jsp:scriptlet>

	<!-- MODALS -->

	<div id="add-group-modal" class="w3-modal">
		<div class="w3-modal-content w3-card-8">

			<header class="w3-container w3-blue-grey">
				<span
					onclick="document.getElementById('add-group-modal').style.display = 'none'"
					class="w3-closebtn">&times;</span>
				<h2>Add new group</h2>
			</header>

			<div class="w3-container">
				<form id="addGroup"
					class="w3-container w3-margin-16" action="group/add" method="post">

					<label>Enter name of new group</label> <input
						id="add-group-name" class="w3-input w3-border" type="text"
						name="name" required>
					<button class="w3-btn w3-blue-grey w3-margin-16 w3-right"
						type="submit">Submit</button>

				</form>
			</div>

		</div>
	</div>

	<div id="add-user-modal" class="w3-modal">
		<div class="w3-modal-content w3-card-8">

			<header class="w3-container w3-blue-grey">
				<span
					onclick="document.getElementById('add-user-modal').style.display = 'none'"
					class="w3-closebtn">&times;</span>
				<h2>Add new user</h2>
			</header>

			<div class="w3-container">
				<form id="addUser" class="w3-container w3-margin-16"
					action="user/add" method="post">

					<label>Username</label> <input id="add-user-username"
						class="w3-input w3-border" type="text" name="username" required>
					<label>Password</label> <input id="add-user-password"
						class="w3-input w3-border" type="password" name="password"
						required> <label>First Name</label> <input
						id="add-user-first-name" class="w3-input w3-border" type="text"
						name="firstName" required> <label>Last Name</label> <input
						id="add-user-last-name" class="w3-input w3-border" type="text"
						name="lastName" required> <label>Birth date</label> <input
						id="add-user-date" class="w3-input w3-border" type="text"
						name="birthDate" required> <label
						id="add-user-date-error" class="w3-small w3-text-red"></label>
					<p></p>

					<label>Specify groups to which user should belong:</label>
					<fieldset id="add-user-checkboxes">
						<c:forEach var="group" items="${groups}">
							<p>
								<input type="hidden" value="${group.getId()}"> <input
									class="w3-check" type="checkbox"><label>${group.getName()}</label>
							</p>
						</c:forEach>
					</fieldset>

					<button class="w3-btn w3-blue-grey w3-margin-16 w3-right"
						type="submit">Submit</button>

				</form>
			</div>

		</div>
	</div>

	<div id="edit-group-modal" class="w3-modal">
		<div class="w3-modal-content w3-card-8">

			<header class="w3-container w3-blue-grey">
				<span
					onclick="document.getElementById('edit-group-modal').style.display = 'none'"
					class="w3-closebtn">&times;</span>
				<h2>Edit group</h2>
			</header>

			<div class="w3-container">
				<form id="editGroup" class="w3-container w3-margin-16"
					action="group/edit" method="post">

					<div id="edit-group-message" class="w3-margin-bottom"></div>
					<input id="edit-group-id" type="hidden" name="id"> <label>Enter
						new name of group</label> <input id="edit-group-name"
						class="w3-input w3-border" type="text" name="name" required>
					<button class="w3-btn w3-blue-grey w3-margin-16 w3-right"
						type="submit">Submit</button>

				</form>
			</div>

		</div>
	</div>

	<div id="edit-user-modal" class="w3-modal">
		<div class="w3-modal-content w3-card-8">

			<header class="w3-container w3-blue-grey">
				<span
					onclick="document.getElementById('edit-user-modal').style.display = 'none'"
					class="w3-closebtn">&times;</span>
				<h2>Edit user</h2>
			</header>

			<div class="w3-container">
				<form id="editUser" class="w3-container w3-margin-16"
					action="user/edit" method="post">

					<div id="edit-user-message" class="w3-margin-bottom"></div>
					<input id="edit-user-id" type="hidden" name="id"> <label>Username</label>
					<input id="edit-user-username" class="w3-input w3-border" type="text"
						name="username" required> <label>Password</label> <input
						id="edit-user-password" class="w3-input w3-border" type="password"
						name="password" required> <label>First Name</label> <input
						id="edit-user-first-name" class="w3-input w3-border" type="text"
						name="firstName" required> <label>Last Name</label> <input
						id="edit-user-last-name" class="w3-input w3-border" type="text"
						name="lastName" required> <label>Birth date</label> <input
						id="edit-user-date" class="w3-input w3-border" type="text"
						name="birthDate" required> <label
						id="edit-user-date-error" class="w3-small w3-text-red"></label>
					<p></p>
					
					<fieldset id="edit-user-checkboxes">
						<c:forEach var="group" items="${groups}">
							<p>
								<input type="hidden" value="${group.getId()}"> <input
									class="w3-check" type="checkbox"><label>${group.getName()}</label>
							</p>
						</c:forEach>
					</fieldset>

					<button class="w3-btn w3-blue-grey w3-margin-16 w3-right"
						type="submit">Submit</button>

				</form>
			</div>

		</div>
	</div>

	<!--PAGE CONTENT-->

	<div
		class="w3-container w3-white w3-border w3-center w3-margin-bottom w3-padding-jumbo header">Users
		Management</div>

	<section class="w3-container w3-third groups-section">

		<div class="w3-xlarge">Groups</div>

		<table class="w3-table w3-border w3-striped w3-hoverable"
			id="groups-table">

			<tr class="w3-blue-grey">
				<th>ID</th>
				<th>Name</th>
				<th></th>
				<th></th>
			</tr>

			<c:forEach var="group" items="${groups}">
				<tr>
					<td>${group.getId()}</td>
					<td onclick="groupSelection(this)">${group.getName()}</td>
					<td class="w3-hover-text-orange"
						onclick="groupEdit(this.parentNode)"><i
						class="fa fa-pencil-square-o" aria-hidden="true"></i></td>
					<td class="w3-hover-text-red" onclick="groupDelete(this.parentNode)"><i
						class="fa fa-times" aria-hidden="true"></i></td>
				</tr>
			</c:forEach>

			<tr>
				<td></td>
				<td onclick="showAllGroups()">Show all...</td>
				<td></td>
				<td></td>
			</tr>

		</table>

		<div class="w3-margin-8 w3-center">
			<button class="w3-btn w3-blue-grey add-button"
				onclick="document.getElementById('add-group-modal').style.display = 'block'">Add</button>
		</div>


	</section>


	<section class="w3-twothird users-section">

		<div class="w3-xlarge">Users</div>

		<table class="w3-table w3-border w3-striped w3-hoverable"
			id="users-table">
			<thead>
				<tr class="w3-blue-grey">
					<th>ID</th>
					<th>Nickname</th>
					<th>Password</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Birth Date</th>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="user" items="${users}">
					<tr>
						<td>${user.getId()}</td>
						<td>${user.getName()}</td>
						<td>${user.getPassword()}</td>
						<td>${user.getFirstName()}</td>
						<td>${user.getLastName()}</td>
						<td>${user.getBirthDate()}</td>
						<td class="w3-hover-text-blue"
							onclick="showGroups(this.parentNode)"><i class="fa fa-users"
							aria-hidden="true"></i></td>
						<td class="w3-hover-text-orange"
							onclick="userEdit(this.parentNode)"><i
							class="fa fa-pencil-square-o" aria-hidden="true"></i></td>
						<td class="w3-hover-text-red" onclick="userDelete(this.parentNode)"><i
							class="fa fa-times" aria-hidden="true"></i></td>
					</tr>


					<tr class="w3-hide">
						<td></td>
						<td class="w3-small"><c:forEach var="group"
								items="${user.getGroups()}">
							${group.getName()}<br>
							</c:forEach></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>


				</c:forEach>
			</tbody>
		</table>

		<div class="w3-margin-8 w3-center">
			<button class="w3-btn w3-blue-grey add-button" onclick="userAdd()">Add</button>
		</div>

	</section>

	<script src="lib/jquery/jquery-2.1.3.min.js"></script>
	<script src="lib/bootstrap/bootstrap.min.js"></script>
	<script src="js/groupsFilter.js"></script>
	<script src="js/groupsProcessing.js"></script>
	<script src="js/usersProcessing.js"></script>

</body>
</html>
