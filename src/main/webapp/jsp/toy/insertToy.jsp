
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/styleTest.css">
<title>Novo Brinquedo</title>
<style>

.categorysNT {
    margin-right: 10px; /* Espaçamento entre o rótulo e o checkbox */
    vertical-align: middle; /* Alinhar verticalmente com o checkbox */
}

.checkbox-label {
    display: flex; /* Alinha o checkbox e o texto na mesma linha */
    align-items: center; 
    /* Alinha verticalmente */
}

.categorysET {
    margin-left: 5px; /* Espaçamento entre o checkbox e o texto */
}

</style>
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
			<a href="ToyController?action=getAllToy">Home</a> <a
				href="CategoryController?action=getAllCategory">Catálogo</a> <a
				href="ToyController?action=getAllToyAdm">Administração</a> <a
				href="html/sobre_a_equipe.html">Sobre a Equipe</a>
		</div>
	</nav>


	<a class="botao" href="ToyController?action=getAllToyAdm">Back</a>
	
	
	<main id="Main_ContentNT" class="Container_NewToy">
		<form id="Content_NewToy" action="ToyController" method="POST"
			enctype="multipart/form-data">
			<input type="hidden" name="action" value="insertToy">

			<div class="title_textNT">
				<h1 class="Text_NT">Catálogo de Brinquedos: Novo Brinquedo</h1>
			</div>

			<div class="fieldsetNT_box">
				<label for="name_NT">Nome</label> <input type="text"
					placeholder="Digite o Nome do Brinquedo" name="toy_name"
					id="name_NT" required>
			</div>

			<div class="fieldsetNT_box">
				<label for="brand_NT">Marca</label> <input type="text"
					placeholder="Digite o nome da Marca do Brinquedo" name="toy_brand"
					id="brand_NT" required>
			</div>

			<div class="fieldsetNT_box">
				<label for="description_NT">Descrição</label> <input type="text"
					placeholder="Digite a Descrição do Brinquedo"
					name="toy_description" id="description_NT" required>
			</div>

			<div class="fieldsetNT_box">
				<label for="file_NT">Imagem</label> <input type="file"
					name="toy_image" id="file_NT" required>
			</div>

			<div class="fieldsetNT_box">
				<label for="price_NT">Valor R$</label> <input type="number" min="0"
					max="1000000000" step="0.01" placeholder="Digite o Valor"
					class="price_nt" name="toy_price" id="price_NT" required>
			</div>

			<div class="categoryNT_Box">
				<div class="fieldsetNT_boxCTG">

					<p class="category_NTP">Categorias:</p>

					<%
					List<Category> list = (ArrayList) request.getAttribute("categoryList");
					String message = (String) request.getParameter("message1");
					for (Category category : list) {
					%>
					<div class="checkbox-label">
					<input type="checkbox" name="toy_categories" id="category_NT1"
						value="<%=category.getCategoryCode()%>"> <label class="categorysET"><%=category.getCategoryName()%></label><br>
					</div>
					<%
					}
					%>

				</div>
			</div>

			<div class="details_ET">
				<label for="details_NT">Detalhes</label>
				<textarea class="details_BoxET" maxlength="1080" placeholder="Escreva os Detalhes do Brinquedo" name="toy_details"  id="details_NT"></textarea>
			</div>

			<div class="fieldsetNT_btn">
				<input id="btn_NT" type="submit" value="Salvar">
			</div>
			<br>
			<br>
			<p>
				<%
				if (!(message == null))
					out.print(message);
				%>
			</p>

		</form>

	</main>
</body>
</html>