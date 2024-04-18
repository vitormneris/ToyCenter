<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
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
				<a href="ToyController?action=getAllToy"> <img
					src="image/newLogo.svg" alt=""></a>
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

	<div class="containerAdm">
		<div class="camada0">
			<div class="camada1">
				<h2 class="subtitulo">Administração: Brinquedos</h2>
				<div class="tabela">
					<table>
						<thead>
							<tr>
								<th>Código do brinquedo</th>
								<th>Imagem do brinquedo</th>
								<th>Nome do brinquedo</th>
								<th>Categorias do brinquedo</th>
								<th>Marca do brinquedo</th>
								<th>Preço do brinquedo</th>
								<th>Descrição do brinquedo</th>
								<th>Detalhes do brinquedo</th>
								<th>Operações do brinquedo</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Toy> list = (ArrayList) request.getAttribute("toyList");
							String message = (String) request.getAttribute("message");
							int c = 0;
							if (list != null) {
								for (Toy toy : list) {
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
								<td><%=toy.getToyCode()%></td>
								<td><a
									href="ToyController?action=getOneToy&toy_code=<%=toy.getToyCode()%>">
										<img src="<%=toy.getToyImage()%>" width="100px" height="100px">
								</a></td>
								<td class="toy-compact-cell"><%=toy.getToyName()%></td>
								<td class="toy-compact-cell">
									<%
									for (Category category : toy.getToyCategories()) {
										out.print(category.getCategoryName());
									%> <br> <%
									 }
									 %>
								</td>
								<td class="toy-compact-cell"><%=toy.getToyBrand()%></td>
								<td><%=toy.getToyPrice()%></td>
								<td class="toy-compact-cell"><%=toy.getToyDescription()%></td>
								<td class="toy-compact-cell"><%=toy.getToyDetails()%></td>
								<td class="controls"><a class="linkDelete" onclick="deleteToy(<%= toy.getToyCode()%>)">Deletar</a> 
								<a class="linkEdit" href="ToyController?action=updateToy&toy_code=<%=toy.getToyCode()%>">Atualizar</a>
								</td>
							</tr>

							<%
								}
							} else {
								out.println("Toy not found");
							}
							%>
						</tbody>
					</table>

				</div>
				<br> <br> 
				<a class="botao"href="ToyController?action=insertToy">Adicionar</a> 
				<a class="botao" href="UserController?action=getAllUser">Administrar usuário</a>
				<a class="botao" href="CategoryController?action=getAllCategoryAdm">Administrar categoria</a> 
				<a class="botao" onclick="logOff()">Deslogar</a>
			</div>

		</div>
	</div>
	
	<p>
		<%
		if (!(message == null))
			out.print(message);
		%>
	</p>
	<script>
	function deleteToy(number) {
	    if (window.confirm("Do you really want to delete the toy?")) {
	        console.log("Toy deleted successfully!");
	        fetch('http://localhost:8080/ToyCenter/ToyController?action=deleteToy&toy_code=' + number, {
	            method: 'POST', 
	        })
	        .then(response => {
	            console.log('Server response:', response);
	            window.location.href = "http://localhost:8080/ToyCenter/ToyController?action=getAllToyAdm";
	        })
	        .catch(error => {
	            console.error('Request error:', error);
	        });
	    } else {
	        console.log("Deletion canceled by toy.");
	        
	    }
	}
	
	function logOff() {
	    if (window.confirm("Do you really want to quit?")) {
	        console.log("User quit successfully!");
	        fetch('http://localhost:8080/ToyCenter/UserController?action=logOut', {
	            method: 'GET', 
	        })
	        .then(response => {
	            console.log('Server response:', response);
	            window.location.href = "http://localhost:8080/ToyCenter/ToyController?action=getAllToyAdm";
	        })
	        .catch(error => {
	            console.error('Request error:', error);
	        });
	    } else {
	        console.log("User not quit.");
	        
	    }
	}

  </script>
	
</body>
</html>