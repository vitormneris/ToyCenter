<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>User Center</title>
	</head>
<body>
	<ul>
		<li><a href="UserController?action=getAllUser">Back</a></li>
	</ul>
	<h2>Delete user</h2>
	<jsp:useBean id="user" scope="session" class="br.edu.toycenter.model.User" />

	<form action="UserController?action=deleteUser" method="POST">
		<table border="1">
			<tr>
				<td>Code</td>
				<td><input type="number" size="60" name="user_code" value="<%= user.getUserCode() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="Submit" /></th>
			</tr>
		</table>
	</form>
</body>
</html>