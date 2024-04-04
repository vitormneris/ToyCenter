<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<%@ page import="br.edu.toycenter.model.User"%>
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
	<h2>Update User</h2>
	<jsp:useBean id="user" scope="session" class="br.edu.toycenter.model.User" />
	<% String message = (String) request.getAttribute("message"); %>
	<form action="UserController?action=updateUser" method="POST" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>User code</td>
				<td><input type="number" size="10" name="user_code" value="<%=user.getUserCode()%>" readonly="readonly" required></td>
			</tr>
			<tr>
				<td>User name</td>
				<td><input type="text" size="150" name="user_name" value="<%=user.getUserName()%>" required></td>
			</tr>
			<tr>
				<td>User e-mail</td>
				<td><input type="email" size="150" name="user_email" value="<%=user.getUserEmail()%>" required></td>
			</tr>
			<tr>
				<td>User password</td>
				<td><input type="password" size="150" name="user_password" value="<%=user.getUserPassword()%>" required></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="Submit" /></th>
			</tr>
		</table>
		<p> <% if (!(message == null)) out.print(message); %> </p>
	</form>
</body>
</html>