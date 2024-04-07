<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
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
	<nav>
		<ul>
			<li><a href="ToyController?action=getAllToy" >Main page</a></li>
			<li><a href="ToyController?action=getAllToyAdm" >Administration</a></li>
			<li><a href="CategoryController?action=getAllCategory" >Categories</a></li>
		</ul>
	</nav>
	<% Category category = (Category) request.getAttribute("category"); %>
	<h1><%= category.getCategoryName() %></h1>
	<table width="60%" border="1">
		<tr>
			<th colspan="7"> <h1>Home</h1> </th>
		</tr>
		<tr>
			<th>Toy Code</th>
			<th>Toy Image</th>
			<th>Toy Name</th>
			<th>Toy Brand</th>
			<th>Toy Price</th>
			<th>Toy Description</th>
			<th>Toy Details</th>
		</tr>
		<%
		String message = (String) request.getAttribute("message");
		for (Toy toy : category.getCategoryToys()) {
		%>
			<tr>
				<td><%= toy.getToyCode() %></td>
				<td><a href="ToyController?action=getOneToy&toy_code=<%= toy.getToyCode() %>">
						<img src="<%= toy.getToyImage() %>" width="100px" height="100px">
					</a>
				</td>
				<td><%= toy.getToyName() %></td>
				<td><%= toy.getToyBrand() %></td>
				<td><%= toy.getToyPrice() %></td>
				<td><%= toy.getToyDescription() %></td>
				<td><%= toy.getToyDetails() %></td>
			</tr>
		<%
		}
		%>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>