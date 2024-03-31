<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<%@ page import="br.edu.toycenter.model.Category"%>
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
			<th colspan="8"> <h1>Toy</h1> </th>
		</tr>
		<tr>
			<th>Toy Code</th>
			<th>Toy Image</th>
			<th>Toy Name</th>
			<th>Toy Category</th>
			<th>Toy brand</th>
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
				<td><img src="<%= toy.getToyImage() %>" width="400px" height="400px"></td>
				<td><%= toy.getToyName() %></td>
				<td>
					<% for (Category category : toy.getToyCategories()) { 
							out.print(category.getCategoryName()); %> <br>
					<%	
						} 
					%> 
				</td>
				<td><%= toy.getToyBrand() %></td>
				<td><%= toy.getToyPrice() %></td>
				<td><%= toy.getToyDescription() %></td>
				<td><%= toy.getToyDetails() %></td>
			</tr>
		<tr>
			<th colspan="8"> <a href="index.html">Main page</a> </th>
		</tr>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>