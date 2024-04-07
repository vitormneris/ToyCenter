<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Main page</title>
	</head>
<body>
	<%
	String message = (String) request.getAttribute("message");
	if (!(message == null)) out.print(message);
	%>
	<script>window.location.href='ToyController?action=getAllToy';</script>
</body>
</html>