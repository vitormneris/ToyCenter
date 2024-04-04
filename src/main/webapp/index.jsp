<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Main page</title>
	</head>
<body>
	<nav>
		<ul>
			<li><a href="html/user/insertUser.html" >Sign up</a></li>
		</ul>
	</nav>
	<form action="UserController" method="POST">
		<input type="hidden" name="action" value="loginUser">
		<table border="1">
			<tr>
				<th colspan="2"> <h1>User login</h1> </th>
			</tr>
			<tr>
				<td>E-mail</td>
				<td> <input type="email" name="user_email" size="70" placeholder="Type a e-mail" required> </td>
			</tr>
			<tr>
				<td>Password</td>
				<td> <input type="password" name="user_password" size="70" placeholder="Type a password" required> </td>
			</tr>
			<tr>
				<td colspan="2" align="center"> <input type="submit" value="Submit"> </td>
			</tr>
		</table>
	</form>
	<%
	String message = (String) request.getAttribute("message");
	if (!(message == null)) out.print(message);
	%>
</body>
</html>