<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleindex.css">
    <link rel="stylesheet" href="css/styleToy.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap"
        rel="stylesheet">
    <title>Brinquedo</title>
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
    
		<%
		Toy toy = (Toy) request.getAttribute("toy");
		String message = (String) request.getAttribute("message");
		%>
	     <div class="containerToy">
	        <div class="toyContent">
	            <div class="toyInfo row">
	               <div>
		                <img class="image" src="<%= toy.getToyImage() %>" alt="">
		                <h3 class="brand"><%= toy.getToyBrand() %></h3>
	               </div>
	
	               <div>
	                <h2 class="name"><%= toy.getToyName() %></h2>
	                <p class="price">R$<%= toy.getToyPrice() %></p>
	              </div>
	
	              <div>
	                <p class="description"><%= toy.getToyDescription() %></p>
	                <p class="details"><%= toy.getToyDetails() %></p>
	             </div>
            </div>
        </div>
    </div> 
    <p> <% if (!(message == null)) out.print(message); %> </p>
    
</body>
</html>