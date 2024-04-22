<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/remodel.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <title>Toy Center in�cio</title>
</head>

<body>
    <header>
		<nav class="nav-logo">
			<div class="logo">
				<a href="ToyController?action=getAllToy"> <img
					src="image/logoToyCenterAlt.svg" alt=""></a>
			</div>

			<div class="store-name">
				<h1>TOY CENTER</h1>
			</div>

			<div class="space"></div>
		</nav>

		<nav class="menu">
			<div class="menuList">
				<a href="ToyController?action=getAllToy">In�cio</a> 
				<a href="CategoryController?action=getAllCategory">Categorias</a> 				
				
				<div class="dropdown">
 				<button class="dropbtn">Administra��o</button>
  				<div class="dropdown-content">
				<a href="ToyController?action=getAllToyAdm">Brinquedos</a>
				<a href="CategoryController?action=getAllCategoryAdm">Categorias</a>
				<a href="UserController?action=getAllUser">Usuarios</a>
  				</div>
				</div>
			
				<a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
			</div>
		</nav>

	</header>


    
    <%
        List<Toy> list = (ArrayList) request.getAttribute("toyList");
        boolean show = false;
        int codeCat = 0;
        if (list != null) {
        	for (Toy toy : list) {
        		for (Category category : toy.getToyCategories()) {
        	if (category.getCategoryName().equals("Hot Wheels")) {
        		show = true;
        		codeCat = category.getCategoryCode();
        	}
        		}
        	}
        	if (show) {
        %>
    <main class="banner_container">
            <div class="banner_content">
               <a href="CategoryController?action=getOneCategory&category_code=<%= codeCat %>" ><img src="image/mp-brinquedos-hotwheels.png" alt=""></a>
            </div>
    </main>
	<%
		}
	}
	%>
	
    <div class="title-container">
        <h1 class="title">Principais brinquedos</h1>
        <div class="title-line" align="center" ></div>
    </div>

    <div class="cards-container">
        <div class="row">
        <%
        boolean cmf = false; 
		if (list != null) {
			for (Toy toy : list) {
	    %>
	            <div class="card">
	                <a class="centralize" href="ToyController?action=getOneToy&toy_code=<%= toy.getToyCode() %>">
	                	<img src="<%= toy.getToyImage() %>" alt="Image" title="Ver mais sobre <%= toy.getToyName() %>"></a>
	                <h4><%= toy.getToyName() %></h4>
	                <p>R$<%= toy.getToyPrice() %></p>
	            </div>
	    <%
			}
		cmf = true;
		} else {
	    %>
			<p style="color: white; font-size: 30px">
	    <%
			out.print("Toy not found");
		%>	
			</p>
		<%
		}
	    %>
        </div>
    </div>
    <% if (cmf) {%>
		<div class="title-container">
	        <h1 class="title">Veja tamb�m: Instrumentos Musicais</h1>
	        <div class="title-line" align="center" ></div>
	    </div>
	    
    <% } %>    		
    <div class="cards-container">
        <div class="row">
        <%
		if (list != null) {

			for (Toy toy : list) {
				for (Category category : toy.getToyCategories()) {
					if (category.getCategoryName().equals("Instrumentos Musicais")) {
		%>
	            <div class="card">
	                <a href="ToyController?action=getOneToy&toy_code=<%= toy.getToyCode() %>">
	                	<img src="<%= toy.getToyImage() %>" alt="Image" title="Ver mais sobre <%= toy.getToyName() %>"></a>
	                <h4><%= toy.getToyName() %></h4>
	                <p>R$<%= toy.getToyPrice() %></p>
	            </div>
        <%
					}
				}
			}
		} 
		%>
        </div>
    </div>
</body>
</html>


