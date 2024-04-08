<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.User"%>
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
        <h2 class="subtitulo">Administração : Usuarios</h2>
            <div class="tabela">
            <table>
                <thead>
                    <tr>
                        <th>User Code</th>
                        <th>User Name</th>
                        <th>User Email</th>
                        <th>User Password</th>
                        <th>User Operations</th>
                    </tr>
                </thead>
                <tbody>  
    				<%
					List<User> list = (ArrayList) request.getAttribute("userList");
					String message = (String) request.getAttribute("message");
					for (User user : list) {
					%>
						<% if (user.getUserCode() % 2 == 0) { %>
							<tr class="trb">
						<%	} else { %>
							<tr class="trw">
						<% } %>
							<td><%= user.getUserCode() %></td>
							<td><%= user.getUserName() %></td>
						    <td><%= user.getUserEmail() %></td>
							<td><%= user.getUserPassword() %></td>

							<td class="controls">
							    <a  class="linkDelete" href="UserController?action=deleteUser&user_code=<%= user.getUserCode() %>">Delete</a>
				    			<a  class="linkEdit" href="UserController?action=updateUser&user_code=<%= user.getUserCode() %>">Update</a>
							</td>
						</tr>
					<%
					}
					%>
               </tbody>
           </table>         
        </div>
        <br><br>
        <a class="botao" href="UserController?action=insertUser">Adicionar</a>
       	<a class="botao" href="ToyController?action=getAllToyAdm">Toy ADM</a>
       	<br><br>
        <p> <% if (!(message == null)) out.print(message); %> </p>
    </div>
    </div>
</div>
</body>
</html>