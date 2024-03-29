<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Toy Center</title>
	</head>
<body>
	<h2>Update Toy</h2>
	<jsp:useBean id="toy" scope="session" class="br.edu.toycenter.model.Toy" />

	<form action="ToyController?action=updateToy" method="POST" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>Toy code</td>
				<td><input type="number" size="10" name="toy_code" value="<%=toy.getToyCode()%>" readonly="readonly" required></td>
			</tr>
			<tr>
				<td>Toy image</td>
				<td><img src="<%=toy.getToyImage()%>" width="400px" height="400px"> <br> <input type="file" name="toy_image"></td>
			</tr>
			<tr>
				<td>Toy name</td>
				<td><input type="text" size="150" name="toy_name" value="<%=toy.getToyName()%>" required></td>
			</tr>
			<tr>
				<td>Toy price</td>
				<td><input type="number" min="0" step="0.01" name="toy_price" value="<%=toy.getToyPrice()%>" required></td>
			</tr>
			<tr>
				<td>Toy description</td>
				<td><input type="text" size="150" name="toy_description" value="<%=toy.getToyDescription()%>" required></td>
			</tr>
			<tr>
				<td>Toy details</td>
				<td><input type="text" size="150" name="toy_details" value="<%=toy.getToyDetails()%>" required></td>
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