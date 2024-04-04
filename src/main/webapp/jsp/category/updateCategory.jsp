<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Category Center</title>
	</head>
<body>
	<ul>
		<li><a href="CategoryController?action=getAllCategoryAdm">Back</a></li>
	</ul>
	<h2>Update Category</h2>
	<jsp:useBean id="category" scope="session" class="br.edu.toycenter.model.Category" />

	<form action="CategoryController?action=updateCategory" method="POST">
		<table border="1">
			<tr>
				<td>Category code</td>
				<td><input type="number" size="10" name="category_code" value="<%=category.getCategoryCode()%>" readonly="readonly" required></td>
			</tr>
			<tr>
				<td>Category name</td>
				<td><input type="text" size="150" name="category_name" value="<%=category.getCategoryName()%>" required></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="Submit" /></th>
			</tr>
		</table>
	</form>
</body>
</html>