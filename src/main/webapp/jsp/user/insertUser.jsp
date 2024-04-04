<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>User page</title>
	</head>
<body>
	<ul>
		<li><a href="UserController?action=getAllUser">Back</a></li>
	</ul>
	
	<form action="UserController" method="POST">
		<input type="hidden" name="action" value="insertUser">
		<table border="1">
			<tr>
				<th colspan="4"> <h1>User registration</h1> </th>
			</tr>
			<tr>
				<td>Code</td>
				<td> <input type="number" name="user_code" size="10" placeholder="Type a code" required> </td>
			</tr>
			<tr>
				<td>Name</td>
				<td> <input type="text" name="user_name" size="150" placeholder="Type a name" required> </td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td> <input type="email" name="user_email" size="150" placeholder="Type a e-mail" required> </td>
			</tr>
			<tr>
				<td>Password</td>
				<td> <input type="password" name="user_password" size="150" placeholder="Type a password" required> </td>
			</tr>
			<tr>
				<td colspan="4" align="center"> <input type="submit" value="Submit"> </td>
			</tr>
		</table>
	</form>
</body>
</html>