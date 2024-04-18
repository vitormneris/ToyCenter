<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="br.edu.toycenter.model.Category"%>
<%@ page import="br.edu.toycenter.model.Toy"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styleTest.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/css/multi-select-tag.css">
	<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag@3.0.1/dist/js/multi-select-tag.js"></script>
    <title>Atualizar Brinquedo</title>
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
    

	<a class="botao" href="ToyController?action=getAllToyAdm">Voltar</a>


    <main id="Main_ContentET" class="Container_EditToy">
        <jsp:useBean id="toy" scope="session" class="br.edu.toycenter.model.Toy" />
        <form id="Content_EditToy" action="ToyController?action=updateToy" method="POST" enctype="multipart/form-data">

            <div class="title_textET">
            <h1 class="Text_ET">Catálogo de Brinquedos: Editar Brinquedo</h1>
            </div>
            
            <div class="fieldsetET_box">
                <label for="code_ET">Code</label>
                <input type="number" placeholder="Digite o Código do Brinquedo" readonly="readonly" name="toy_code" id="code_ET" 
                	value="<%=toy.getToyCode()%>">
            </div>

            <div class="fieldsetET_box">
                <label for="name_ET">Nome</label>
                <input type="text" placeholder="Digite o Novo Nome do Brinquedo" name="toy_name" id="name_ET" value="<%=toy.getToyName()%>">
            </div>
            
            <div class="fieldsetET_box">
            <label for="brand_ET">Marca</label>
            <input type="text" placeholder="" name="toy_brand" id="brand_ET" value="<%=toy.getToyBrand()%>">
            </div>

            <div class="fieldsetET_box">
            <label for="description_ET">Descrição</label>
            <input type="text" placeholder="Digite a Nova Descrição do Brinquedo" name="toy_description" id="description_ET" 
            	value="<%=toy.getToyDescription()%>">
            </div>
            
            <div class="fieldsetET_box">
            <label for="file_ET">Imagem</label>
            <input type="file" name="toy_image" id="file_ET">
            <img class="img_show" src="<%=toy.getToyImage()%>" width="400px" height="400px">
            </div>

            <div class="fieldsetET_box">
            <label for="price_ET">Valor R$:</label>
            <input type="number" placeholder="Digite o Valor" min="0" step="0.01" class="price_et" name="toy_price"
            	 id="price_ET" value="<%=toy.getToyPrice()%>">
            </div>


            <div class="categoryET_Box">
                <div class="fieldsetET_boxCTG">
                    <p class="category_ETP">Categorias:</p>
                    <select name="toy_categories" id="categorias" multiple>
                    <%
                    List<Category> list = (ArrayList) request.getAttribute("categoryList");
                    String message = (String) request.getAttribute("message");
                    String message1 = (String) request.getAttribute("message1");

                    for (Category category : list) {
                        boolean status = false;
                        for (Category toyCategory : toy.getToyCategories()) {
                            if (category.getCategoryCode() == toyCategory.getCategoryCode()) {
                    %>
                               <option value="<%= category.getCategoryCode() %>" selected><%= category.getCategoryName() %></option>
                    <%
                                status = true;
                                break;
                            }
                        }
                        if (!status) {
                    %>
                               <option value="<%= category.getCategoryCode() %>"><%= category.getCategoryName() %></option>
                    <%
                        }
                    }
                    %> 

                </div>
            </div>
            
			<label for="details_ET">Detalhes</label>
            <textarea class="details_BoxET" maxlength="1080" placeholder="Escreva os Novos Detalhes do Brinquedo" name="toy_details" 
            id="details_NT"><%=toy.getToyDetails()%></textarea>


			<div class="fieldsetNT_btn">
			    <button id="confirmBtn" onclick="confirmSubmission()">Salvar</button>
			</div>
             <p>
				<%
				if (!(message == null))
					out.print(message);
				 else if (!(message1 == null))
					out.print(message1);
				%>
			</p>
            
        </form>        
    </main>
    	<script>
	    function confirmSubmission() {
	        if (confirm("Tem certeza de que deseja atualizar este brinquedo?")) {
	            document.getElementById("Content_EditToy").submit();
	        } else {
	            return false;
	        }
	    }
	    
	</script>
	<script> new MultiSelectTag('categorias') </script> 
</body>
</html>


