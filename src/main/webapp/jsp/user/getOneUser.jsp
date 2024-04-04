<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.User"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>User list</title>
	</head>
<body>
	<nav>
		<ul>
			<li><a href="UserController?action=getAllUser">Back</a></li>
		</ul>
	</nav>
	<table width="60%" border="1">
		<tr>
			<th colspan="4"> <h1>User</h1> </th>
		</tr>
		<tr>
			<th>User Code</th>
			<th>User Name</th>
			<th>User Email</th>
			<th>User Password</th>
		</tr>
		<%
		User user = (User) request.getAttribute("user");
		String message = (String) request.getAttribute("message");
		%>
		<tr>
			<td><%= user.getUserCode() %></td>
			<td><%= user.getUserName() %></td>
			<td><%= user.getUserEmail() %></td>
			<td><%= user.getUserPassword() %></td>

		</tr>
	
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>