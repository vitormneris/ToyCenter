<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Toy list</title>
	</head>
<body>
	<table width="60%" border="1">
		<tr>
			<th colspan="7"> <h1>Toy list</h1> </th>
		</tr>
		<tr>
			<th>Toy Code</th>
			<th>Toy Image</th>
			<th>Toy Name</th>
			<th>Toy Price</th>
			<th>Toy Description</th>
			<th>Toy Details</th>
			<th>Toy operations</th>
		</tr>
		<%
		List<Toy> list = (ArrayList) request.getAttribute("toyList");
		String message = (String) request.getAttribute("message");
		for (Toy toy : list) {
		%>
			<tr>
				<td><%= toy.getToyCode() %></td>
				<td><img src="<%= toy.getToyImage() %>" width="100px" height="100px"></td>
				<td><%= toy.getToyName() %></td>
				<td><%= toy.getToyPrice() %></td>
				<td><%= toy.getToyDescription() %></td>
				<td><%= toy.getToyDetails() %></td>
				<td>
					<a href="ToyController?action=deleteToy&toy_code=<%= toy.getToyCode() %>">Delete</a>
				    <a href="ToyController?action=updateToy&toy_code=<%= toy.getToyCode() %>">Update</a>
				</td>
			</tr>
		<%
		}
		%>
		<tr>
			<th colspan="7"> <a href="index.html">Main page</a> </th>
		</tr>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>