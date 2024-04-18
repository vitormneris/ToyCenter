<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>Toy Center ADM</title>
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
            <a href="ToyController?action=getAllToy">In�cio</a>
            <a href="CategoryController?action=getAllCategory">Categorias</a>
            <a href="ToyController?action=getAllToyAdm">Administra��o</a>
            <a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
        </div>
    </nav>
    
    <a class="botao1" href="ToyController?action=getAllToyAdm">Voltar</a>
    

	<div class="containerAdm">
	  <div class="camada0">
	    <div class="camada1">
	        <h2 class="subtitulo">Administra��o: Categorias</h2>
	            <div class="tabela">
	            <table>
	                <thead>
	                    <tr>
	                        <th>C�digo da categoria</th>
	                        <th>Imagem da categoria</th>
	                        <th>Nome da categoria</th>
	                        <th>Opera��es da categoria</th>
	                    </tr>
	                </thead>
	                <tbody>                   
	                    <%
						List<Category> categoryList = (ArrayList) request.getAttribute("categoryList");
						String message = (String) request.getAttribute("message");
						int c = 0;
						if (categoryList != null) {
							for (Category category : categoryList) {
								c++;
								if (c % 2 == 0) { 
					    %>
								<tr class="trb">
					    <%	
					  			} else {
					    %>
								<tr class="trw">
					    <% 
					  			} 
					    %>
								<td><%= category.getCategoryCode() %></td>
								<td class="toy-compact-cell" ><%= category.getCategoryName() %></td>
								<td><img src="<%= category.getCategoryImage() %>" width="100px" height="100px"></td>
								<td class="controls">
									<a class="linkDelete" onclick="deleteCategory(<%= category.getCategoryCode() %>)">Deletar</a>
								    <a class="linkEdit" href="CategoryController?action=updateCategory&category_code=<%= category.getCategoryCode() %>">Atualizar</a>
								</td>
							</tr>
						<%
							}
						} else {
							out.println("Category not found");
						}
						%>
	                </tbody>
	            </table>
	        </div>
	        <br>
	        <a class="botao" href="html/category/insertCategory.html">Adicionar</a>
	        <br><br>
            <p> <% if (!(message == null)) out.print(message); %> </p>
            <script>
			function deleteCategory(number) {
			    if (window.confirm("Do you really want to delete the category?")) {
			        console.log("Category deleted successfully!");
			        fetch('http://localhost:8080/ToyCenter/CategoryController?action=deleteCategory&category_code=' + number, {
			            method: 'POST', 
			        })
			        .then(response => {
			            console.log('Server response:', response);
			            window.location.href = "http://localhost:8080/ToyCenter/CategoryController?action=getAllCategoryAdm";
			        })
			        .catch(error => {
			            console.error('Request error:', error);
			        });
			    } else {
			        console.log("Deletion canceled by category.");
			        
			    }
			}
		
		  </script>
	    </div>
	    </div>
    </div>
</body>
</html>