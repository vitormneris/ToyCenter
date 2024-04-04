<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Category list</title>
	</head>
<body>
	<ul>
		<li><a href="ToyController?action=getAllToy" >Main page</a></li>
		<li><a href="ToyController?action=getAllToyAdm" >Administration</a></li>
		<li><a href="CategoryController?action=getAllCategory" >Categories</a></li>
	</ul>
	<table width="60%" border="1">
		<tr>
			<th colspan="3"> <h1>Category list</h1> </th>
		</tr>
		<tr>
			<th>Category Code</th>
			<th>Category Name</th>
		</tr>
		<%
		List<Category> categoryList = (ArrayList) request.getAttribute("categoryList");
		String message = (String) request.getAttribute("message");
		for (Category category : categoryList) {
		%>
			<tr>
				<td> <%= category.getCategoryCode() %></td>
				<td><a href="CategoryController?action=getOneCategory&category_code=<%= category.getCategoryCode() %>">
				<%= category.getCategoryName() %></a></td>
			</tr>
		<%
		}
		%>
	</table>
	
	<p> <% if (!(message == null)) out.print(message); %> </p>
</body>
</html>