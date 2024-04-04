<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Category list</title>
	</head>
<body>
	<table width="60%" border="1">
		<tr>
			<th colspan="2"> <h1>Category</h1> </th>
		</tr>
		<tr>
			<th>Category code</th>
			<th>Category name</th>
		</tr>
		<%
		Category category = (Category) request.getAttribute("category");
		String message = (String) request.getAttribute("message");
		%>
		<tr>
			<td><%= category.getCategoryCode() %></td>
			<td><%= category.getCategoryName() %></td>
		</tr>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>