<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.User"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Toy Center usu�rio</title>
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
				<h2 class="subtitulo">Administra��o: Usu�rios</h2>
				<div class="tabela">
					<table>
						<thead>
							<tr>
								<th>C�digo do usu�rio</th>
								<th>Nome do usu�rio</th>
								<th>E-mail do usu�rio</th>
								<th>Senha do usu�rio</th>
								<th>Opera��es do usu�rio</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<User> list = (ArrayList) request.getAttribute("userList");
							String message = (String) request.getAttribute("message");
							int c = 0;
							for (User user : list) {
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
								<td><%=user.getUserCode()%></td>
								<td class="toy-compact-cell"><%=user.getUserName()%></td>
								<td class="toy-compact-cell"><%=user.getUserEmail()%></td>
								<td class="toy-compact-cell"><%=user.getUserPassword()%></td>

								<td class="controls">
								<a class="linkDelete" onclick="deleteUser(<%= user.getUserCode() %>)">Deletar</a>
								<a class="linkEdit" href="UserController?action=updateUser&user_code=<%=user.getUserCode()%>">Atualizar</a>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				 <a class="botao" href="UserController?action=insertUser">Adicionar</a>
				<p>
					<%
					if (!(message == null)) {
						out.print(message);
					}

					%>
				</p>
			</div>
			<script>
			function deleteUser(number) {
			    if (window.confirm("Do you really want to delete the user?")) {
			        console.log("User deleted successfully!");
			        fetch('http://localhost:8080/ToyCenter/UserController?action=deleteUser&user_code=' + number, {
			            method: 'POST', 
			        })
			        .then(response => {
			            console.log('Server response:', response);
			            window.location.href = "http://localhost:8080/ToyCenter/UserController?action=getAllUser";
			        })
			        .catch(error => {
			            console.error('Request error:', error);
			        });
			    } else {
			        console.log("Deletion canceled by user.");
			        
			    }
			}
		
		  </script>
		</div>
	</div>
</body>
</html>