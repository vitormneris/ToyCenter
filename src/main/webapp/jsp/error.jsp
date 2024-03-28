<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Error</title>
	</head>
<body>
	<%
	String error = (String) request.getAttribute("message");
	%>
	<h1>Message error</h1>
	<p><%= error %></p>
	<a href="index.html">Main page</a> 
</body>
</html>