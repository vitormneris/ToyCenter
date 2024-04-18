<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<%@ page import="br.edu.toycenter.model.User"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleindex.css">
    <link rel="stylesheet" href="css/stylecadastro.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap"
        rel="stylesheet">
    <title>Atualizar usuário</title>
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
    
    <a class="botao" href="UserController?action=getAllUser">Voltar</a>

    <div class="cadastro_container">
    	<jsp:useBean id="user" scope="session" class="br.edu.toycenter.model.User" />
          <% String message = (String) request.getAttribute("message"); %>
    
        <form id="cadastro_form" action="UserController" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="action" value="updateUser">
            <h1 class="cadastro_title">Atualizar usuário</h1>
            
            <label for="code">Code</label>
			<input type="number" size="10" name="user_code" id="code" value="<%=user.getUserCode()%>" readonly="readonly" required>
			
            <label for="nome">Nome</label>
            <input type="text" name="user_name" id="nome" value="<%=user.getUserName()%>" placeholder="Type a name" required>

            <label for="email">Email:</label>
            <input type="email" name="user_email" id="email" value="<%=user.getUserEmail()%>" placeholder="Type a e-mail" required>

            <label for="senha">Senha:</label>
            <input type="password" name="user_password" id="senha" value="<%=user.getUserPassword()%>" placeholder="Type a password" required>

			<div class="fieldsetNT_btn">
			    <button id="confirmBtn" onclick="confirmSubmission()">Salvar</button>
			</div>
            <br><br>
            <p> <% if (!(message == null)) out.print(message); %> </p>
        </form>
    </div>
    <script>
	    function confirmSubmission() {
	        if (confirm("Tem certeza de que deseja salvar este brinquedo?")) {
	            document.getElementById("Content_NewToy").submit();
	        } else {
	            return false;
	        }
	    }
	    
	</script>
</body>
</html>