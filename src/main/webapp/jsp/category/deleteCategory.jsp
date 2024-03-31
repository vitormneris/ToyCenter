<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Category Center</title>
	</head>
<body>
	<h2>Delete category</h2>
	<jsp:useBean id="category" scope="session" class="br.edu.toycenter.model.Category" />

	<form action="CategoryController?action=deleteCategory" method="POST">
		<table border="1">
			<tr>
				<td>Code</td>
				<td><input type="number" size="60" name="category_code" value="<%= category.getCategoryCode() %>" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="Submit" /></th>
			</tr>
			<tr>
				<th colspan="2"><a href="index.html">Main page</a></th>
			</tr>
		</table>
	</form>
</body>
</html>