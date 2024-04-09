<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleTest.css">
    <title>Editar Categoria</title>
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
	

	<a class="botao" href="CategoryController?action=getAllCategoryAdm">Back</a>

	
    <main id="Main_ContentCT" class="Container_EditCategory">
    	<jsp:useBean id="category" scope="session" class="br.edu.toycenter.model.Category" />
		<form id="Content_EditCategory" action="CategoryController?action=updateCategory" method="POST" enctype="multipart/form-data">

            <div class="title_textEC">
                <h1 class="Text_EC">Categoria: Editar Categoria</h1>
            </div>

            <div class="fieldsetEC_box">
                <label for="code_EC">Code</label>
                <input type="number" placeholder="Digite o Código da Categoria" name="category_code"
                    id="code_EC" value="<%=category.getCategoryCode()%>" readonly="readonly" required>
            </div>

            <div class="fieldsetEC_box">
                <label for="name_EC">Nome</label>
                <input type="text" placeholder="Digite o Novo Nome da Categoria" name="category_name" id="name_EC" 
                value="<%=category.getCategoryName()%>" required>
            </div>


            <div class="fieldsetEC_box">
                <label for="file_EC">Imagem</label>
                <input type="file" name="category_image" id="file_EC">
                <img class="img_show" src="<%=category.getCategoryImage()%>"> <br> 
            </div>

            <div class="fieldsetEC_btn">
                <input type="submit" id="btn_EC"> 
            </div>
        </form>
    </main>
</body>

</html>