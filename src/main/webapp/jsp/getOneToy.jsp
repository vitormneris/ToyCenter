<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Toy list</title>
	</head>
<body>
	<table width="60%" border="1">
		<tr>
			<th colspan="6"> <h1>Toy</h1> </th>
		</tr>
		<tr>
			<th>Toy Code</th>
			<th>Toy Image</th>
			<th>Toy Name</th>
			<th>Toy Price</th>
			<th>Toy Description</th>
			<th>Toy Details</th>
		</tr>
		<%
		Toy toy = (Toy) request.getAttribute("toy");
		String message = (String) request.getAttribute("message");
		%>
			<tr>
				<td><%= toy.getToyCode() %></td>
				<td><%= toy.getToyImage() %></td>
				<td><%= toy.getToyName() %></td>
				<td><%= toy.getToyPrice() %></td>
				<td><%= toy.getToyDescription() %></td>
				<td><%= toy.getToyDetails() %></td>
			</tr>
		<tr>
			<th colspan="6"> <a href="index.html">Main page</a> </th>
		</tr>
	</table>
	
	<p> 
		<% 
		if (!(message == null)) {
			out.print(message);
		}
		%>
	</p>
</body>
</html>