<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleindex.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap"
        rel="stylesheet">
    <title>Toy Center categoria</title>
    <style>
        .row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px; 
        }

        .card {
            width: 100%; 
        }
    </style>
</head>

<body>
    <header>
        <nav class="nav-bar">
            <div class="logo">
           		<a href="ToyController?action=getAllToy">
                <img src="image/newLogo.svg" alt=""></a>
            </div>

            <div class="store_name">
                <h1>TOY CENTER</h1>
            </div>

            <div class="space"></div>
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

    <div class="releases_container">
        <div class="row">

		<%
		List<Category> categoryList = (ArrayList) request.getAttribute("categoryList");
		String message = (String) request.getAttribute("message");
		if (categoryList != null) {
			for (Category category : categoryList) {
			%>
				<div class="card">
					<a href="CategoryController?action=getOneCategory&category_code=<%= category.getCategoryCode() %>">
	                <img src="<%= category.getCategoryImage() %>" alt=""></a>
	                <h4><%= category.getCategoryName() %></h4>
	            </div>
		<%
			}
		} else {
			out.println("Category not found");	
		}
		%>

        </div>
    </div>
	<p> <% if (!(message == null)) out.print(message); %> </p>

</body>
</html>


