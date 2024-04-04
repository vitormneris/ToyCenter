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
			<li> <a href="ToyController?action=getAllToy">Main page</a> </li>
			<li><a href="ToyController?action=getAllToyAdm" >Toy Administration</a></li>
			<li><a href="UserController?action=insertUser" >insert user</a></li>
			<li><a href="UserController?action=logOut" >log out user</a></li>
		</ul>
	</nav>
	<table width="60%" border="1">
		<tr>
			<th colspan="5"> <h1>User list</h1> </th>
		</tr>
		<tr>
			<th>User Code</th>
			<th>User Name</th>
			<th>User Email</th>
			<th>User Password</th>
			<th>User Operations</th>
		</tr>
		<%
		List<User> list = (ArrayList) request.getAttribute("userList");
		String message = (String) request.getAttribute("message");
		for (User user : list) {
		%>
			<tr>
				<td><%= user.getUserCode() %></td>
				<td><%= user.getUserName() %></td>
				<td><%= user.getUserEmail() %></td>
				<td><%= user.getUserPassword() %></td>
				<td>
					<a href="UserController?action=deleteUser&user_code=<%= user.getUserCode() %>">Delete</a>
				    <a href="UserController?action=updateUser&user_code=<%= user.getUserCode() %>">Update</a>
				</td>
			</tr>
		<%
		}
		%>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>