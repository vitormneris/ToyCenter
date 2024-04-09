<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

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
            <a href="ToyController?action=getAllToy">Home</a>
            <a href="CategoryController?action=getAllCategory">Catálogo</a>
            <a href="ToyController?action=getAllToyAdm">Administração</a>
            <a href="html/sobre_a_equipe.html">Sobre a Equipe</a>
        </div>
    </nav>
    
	<a class="botao" href="UserController?action=getAllUser">Back</a>

    <div class="cadastro_container">
        <form id="cadastro_form" action="UserController" method="POST">
        	<% String message = (String) request.getAttribute("message"); %>
			<input type="hidden" name="action" value="insertUser">
            <h1 class="cadastro_title">Inserir usuário</h1>

            <label for="nome">Nome</label>
            <input type="text" name="user_name" id="nome" placeholder="Type a name" required>

            <label for="email">Email:</label>
            <input type="email" name="user_email" id="email"  placeholder="Type a e-mail" required>

            <label for="senha">Senha:</label>
            <input type="password" name="user_password" id="senha" placeholder="Type a password" required>

            <div class="fieldsetNT_btn">
            	<input id="cadastro_button" type="submit" value="Salvar">
            </div>
            <br><br>
            <p> <% if (!(message == null)) out.print(message); %> </p>
        </form>
    </div>
</body>
</html>