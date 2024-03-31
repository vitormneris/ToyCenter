<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Toy page</title>
	</head>
<body>
	<form action="ToyController" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insertToy">
		<table border="1">
			<tr>
				<th colspan="2"> <h1>Toy registration</h1> </th>
			</tr>
			<tr>
				<td>Code:</td>
				<td> <input type="number" name="toy_code" size="10" placeholder="Type a code" required> </td>
			</tr>
			<tr>
				<td>Image:</td>
				<td> <input type="file" name="toy_image" required> </td>
			</tr>
			<tr>
				<td>Name:</td>
				<td> <input type="text" name="toy_name" size="150" placeholder="Type a name" required> </td>
			</tr>
			
			<tr>
				<td>Category:</td>
				<td>
					<%
					List<Category> list = (ArrayList) request.getAttribute("categoryList");
					String message = (String) request.getAttribute("message");
					for (Category category : list) {
					%>
						<label> <%= category.getCategoryName() %>
						<input type="checkbox" name="toy_categories" value="<%= category.getCategoryCode() %>" /> </label>
		  			<%
					}
					%>
		  			
  				</td>
    		<tr>
			
			<tr>
				<td>Brand:</td>
				<td> <input type="text" name="toy_brand" size="150" placeholder="Type a brand" required> </td>
			</tr>
			<tr>
				<td>Price:</td>
				<td> <input type="number" name="toy_price" min="0" step="0.010" placeholder="Type a price" required> </td>
			</tr>
			<tr>
				<td>Description:</td>
				<td> <input type="text" name="toy_description" size="150" placeholder="Type a description" required> </td>
			</tr>
			<tr>
				<td>Details:</td>
				<td> <input type="text" name="toy_details" size="150" placeholder="Type a details" required> </td>
			</tr>
			<tr>
				<td colspan="2" align="center"> <input type="submit" value="Submit"> </td>
			</tr>
			<tr>
				<th colspan="2"><a href="index.html">Main page</a></th>
			</tr>
		</table>
		<p> <% if (!(message == null)) out.print(message); %> </p>
	</form>
</body>
</html>