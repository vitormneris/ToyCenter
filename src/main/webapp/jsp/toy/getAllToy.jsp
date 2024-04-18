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
    <link rel="stylesheet" href="css/styleindex.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap" rel="stylesheet">
    <title>Toy Center início</title>
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
        <div class="banner_main">
            <div class="banner_content">
               <a href="CategoryController?action=getOneCategory&category_code=<%= codeCat %>" ><img src="image/mp-brinquedos-hotwheels.png" alt=""></a>
            </div>
        </div>
    </main>
	<%
		}
	}
	%>
	
    <div class="header">
        <h1>Principais brinquedos</h1>
    </div>

    <div class="releases_container">
        <div class="row">
        <%		
		if (list != null) {
			for (Toy toy : list) {
	    %>
	            <div class="card">
	                <a href="ToyController?action=getOneToy&toy_code=<%= toy.getToyCode() %>">
	                	<img src="<%= toy.getToyImage() %>" alt="Image" title="Ver mais sobre <%= toy.getToyName() %>"></a>
	                <h4><%= toy.getToyName() %></h4>
	                <p>R$<%= toy.getToyPrice() %></p>
	            </div>
	    <%
			}
		} else {
			out.print("Toy not found");
		}
	    %>
        </div>
    </div>
    
    <div class="header">
        <h1>Veja também: Instrumentos Musicais</h1>
    </div>
    
    <div class="releases_container">
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


