<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>TOY Center</title>
	  <link rel="stylesheet" href="css/styleAdm.css">
	  <link rel="stylesheet" href="css/styleindex.css">
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
	    </nav>
	  </header>
    <nav class="menu">
        <div class="menuList">
            <a href="ToyController?action=getAllToy">Home</a>
            <a href="CategoryController?action=getAllCategory">Catálogo</a>
            <a href="ToyController?action=getAllToyAdm">Administração</a>
            <a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
        </div>
    </nav>

	<div class="containerAdm">
	  <div class="camada0">
	    <div class="camada1">
	        <h2 class="subtitulo">Administração : Categorias</h2>
	            <div class="tabela">
	            <table>
	                <thead>
	                    <tr>
	                        <th>Código da categoria</th>
	                        <th>Imagem da categoria</th>
	                        <th>Nome da categoria</th>
	                        <th>User Operations</th>
	                    </tr>
	                </thead>
	                <tbody>                   
	                    <%
						List<Category> categoryList = (ArrayList) request.getAttribute("categoryList");
						String message = (String) request.getAttribute("message");
						for (Category category : categoryList) {
						%>
							<% if (category.getCategoryCode() % 2 == 0) { %>
								<tr class="trb">
							<%	} else { %>
								<tr class="trw">
							<% } %>
								<td><%= category.getCategoryCode() %></td>
								<td><%= category.getCategoryName() %></td>
								<td><img src="<%= category.getCategoryImage() %>" width="100px" height="100px"></td>
								<td class="controls">
									<a href="CategoryController?action=deleteCategory&category_code=<%= category.getCategoryCode() %>">Delete</a>
								    <a href="CategoryController?action=updateCategory&category_code=<%= category.getCategoryCode() %>">Update</a>
								</td>
							</tr>
						<%
						}
						%>
	                </tbody>
	            </table>
	        </div>
	        <br>
	        <a class="botao" href="html/category/insertCategory.html">Adicionar</a>
		    <a class="botao" href="ToyController?action=getAllToyAdm">Toy ADM</a>
	        <br><br>
            <p> <% if (!(message == null)) out.print(message); %> </p>
	    </div>
	    </div>
    </div>
</body>
</html>