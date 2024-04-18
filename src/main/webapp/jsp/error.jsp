<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">]
		<link rel="stylesheet" href="css/styleindex.css">
		<link rel="stylesheet" href="css/errorStyle.css">
		<title>Error</title>
	</head>
<body>
	<header>
		<nav class="nav-bar">
			<div class="logo">
				<a href="ToyController?action=getAllToy"> <img
					src="image/newLogo.svg" alt=""></a>
			</div>
			<div class="store_name">
				<h1>TOY CENTER</h1>
			</div>
		</nav>
	</header>
	
    <nav class="menu">
        <div class="menuList">
            <a href="ToyController?action=getAllToy">Início</a>
            <a href="CategoryController?action=getAllCategory">Categorias</a>
            <a href="ToyController?action=getAllToyAdm">Administração</a>
            <a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
        </div>
    </nav>
    
    <div id="erroDiv">
		<%
		String error = (String) request.getAttribute("message");
		%>
		<h1 id="erroH1">Ops... Ocorreu um erro</h1>
		<br><br>
		 
		<p id="erroP">Descrição do erro:  <%= error %></p>
		<a id="erroA" href="index.jsp">Voltar a página inicial</a>
	</div>
</body>
</html>