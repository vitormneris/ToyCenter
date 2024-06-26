package br.edu.toycenter.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import br.edu.toycenter.dao.CategoryDAO;
import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;

@WebServlet("/ToyController")
@MultipartConfig
public class ToyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		try {
    		ToyDAO toydao = new ToyDAO();
    		CategoryDAO categorydao = new CategoryDAO();
    		Toy toy = null;

    		if (action.equals("getAllToy")) {
				getAllToy(request, response, false);
				
			} else if (action.equals("updateToy")) {
				screenBlock(request, response);
        		toy = toydao.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code"))));
        		HttpSession session = request.getSession(true);
		    	List<Category> categoryList = categorydao.getAllCategoryWithToy(false);
		    	request.setAttribute("categoryList", categoryList);
        		session.setAttribute("toy", toy);
	            forwardToPage(request, response, "jsp/toy/updateToy.jsp");
	            
			} else if (action.equals("deleteToy")) {
				screenBlock(request, response);
        		toy = toydao.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("toy", toy);
	            forwardToPage(request, response, "jsp/toy/deleteToy.jsp");
	            
		    }  else if (action.equals("insertToy")) {
				screenBlock(request, response);
		    	List<Category> categoryList = categorydao.getAllCategoryWithToy(false);
        		request.setAttribute("categoryList", categoryList);
	            forwardToPage(request, response, "jsp/toy/insertToy.jsp");
	            
		    } else if (action.equals("getOneToy")) {
        		getOneToy(request, response);
		    } else if (action.equals("getAllToyAdm")) {
				screenBlock(request, response);
        		getAllToy(request, response, true);
		    } 
			
        	request.setAttribute("message", "Page not found");
        	forwardToPage(request, response, "jsp/error.jsp");
	
 		} catch (Exception e) {
        	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
        }
	}
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
        	request.setAttribute("message", "Page not found");
        	forwardToPage(request, response, "jsp/error.jsp");
        }
		
        try {          
            switch (action) {
            	case "getOneToy":
    				getOneToy(request, response);
    				break;
            	case "insertToy":
    				insertToy(request, response);
    				break;
            	case "updateToy":
	        		updateToy(request, response);
                    break;
            	case "deleteToy":
                    deleteToy(request, response);
                    break;
                default:
                	request.setAttribute("message", "Page not found");
                	forwardToPage(request, response, "jsp/error.jsp");
                	break;
            }
        } catch (Exception e) {
        	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
        }
    }
	
    private void getAllToy(HttpServletRequest request, HttpServletResponse response, boolean adm) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		List<Toy> list = td.getAllToy();
		
		request.setAttribute("toyList", list);

    	String msg = (adm) ? "jsp/toy/getAllToyAdm.jsp" :"jsp/toy/getAllToy.jsp";
		
		forwardToPage(request, response, msg);
	}
	
	private void getOneToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy(Integer.parseInt(request.getParameter("toy_code")));
		toy = td.getOneToy(toy);
		
		if (toy != null) {
			request.setAttribute("toy", toy);
	    	forwardToPage(request, response, "jsp/toy/getOneToy.jsp");
		} else {
	    	request.setAttribute("message", "Toy not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void insertToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = createObjectToy(request, response);
		
		String msg =  td.insertToy(toy) ? "Toy inserted sucessfully" : "Unable to create toy";
	    request.setAttribute("message", msg);
	    
		String js = "<script>window.location.href='ToyController?action=getAllToyAdm'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
	}
	
	private void updateToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = createObjectToy(request, response);

		String msg =  td.updateToy(toy) ? "Toy updated sucessfully" : "Unable to update toy";
	    request.setAttribute("message", msg);

		String js = "<script>window.location.href='ToyController?action=getAllToyAdm'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
	} 
	
	private void deleteToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy(Integer.parseInt(request.getParameter("toy_code")));
		
		String msg =  td.deleteToy(toy, true) ? "Toy deleted sucessfully" : "Unable to delete toy";
	    request.setAttribute("message", msg);
		getAllToy(request, response, true);
	}
	
	private Toy createObjectToy(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Toy toy = new Toy();

		
		try {
			if (!(request.getParameter("action").equals("insertToy"))) {
				if (!inputCheck(request, response, "updateToy")) return null;
				toy.setToyCode(Integer.parseInt(request.getParameter("toy_code")));
			} else {
				if (!inputCheck(request, response, "insertToy")) return null;
			}
			toy = setToyCategories(request, response, toy);
			toy.setToyImage(uploadImage(request, response));			
			toy.setToyName(request.getParameter("toy_name"));
			toy.setToyBrand(request.getParameter("toy_brand"));
			toy.setToyPrice(Float.parseFloat(request.getParameter("toy_price")));
			toy.setToyDescription(request.getParameter("toy_description"));
			toy.setToyDetails(request.getParameter("toy_details"));

		} catch (Exception e) {
	    	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
		}
		return toy;
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
	
	private String uploadImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = "/home/vitor/eclipse-workspace/ToyCenter/src/main/webapp/image/dataBaseImageToy";		
		for(Part part : request.getParts()) {
			if (part.getName().equals("toy_image") && part.getSize() > 0) {
				part.write(path + File.separator + part.getSubmittedFileName());
				return "image/dataBaseImageToy" + File.separator + part.getSubmittedFileName();
			}
		}
		
		ToyDAO td = new ToyDAO();
		return td.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code")))).getToyImage();
	}
	
	private Toy setToyCategories(HttpServletRequest request, HttpServletResponse response, Toy toy) throws Exception {
		if (request.getParameter("toy_categories") == null) return null;
		try {
			CategoryDAO categorydao = new CategoryDAO();
			List<Category> categoryList = categorydao.getAllCategoryWithToy(false);
			String[] categoryVector = request.getParameterValues("toy_categories");
			
			for (String categoryStr : categoryVector) 
				for (Category category : categoryList) 
					if (category.getCategoryCode() ==  Integer.parseInt(categoryStr)) 
						toy.addCategory(category);
			
			return toy;
		} catch (Exception e) {
		    request.setAttribute("message", e.getMessage());
	        forwardToPage(request, response, "jsp/error.jsp");
			throw new Exception(e.getMessage());
		}
	}
	
	private void screenBlock(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
	}
	
	private boolean inputCheck(HttpServletRequest request, HttpServletResponse response, String destiny) throws ServletException, IOException {
		boolean error = false;
		String msg = "";
		
		if (request.getParameter("toy_name").trim().equals("") || request.getParameter("toy_name") == null) {	    
			msg = "O nome nao pode ficar em branco.";
			error = true;
		}
		
		if (request.getParameter("toy_brand").trim().equals("") || request.getParameter("toy_brand") == null) {	    	
			msg = "A marca nao pode ficar em branco.";
			error = true;
		}
		
		if (request.getParameter("action").equals("insertToy")) {
			boolean img = false;
			for(Part part : request.getParts()) {
				if (part.getName().equals("toy_image") && part.getSize() > 0) {
					img = true;
				}
			}
			if (!img) {
				msg = "Envie uma imagem";
				error = true;			
			}
		}
		
		if (request.getParameter("toy_price").trim().equals("") || request.getParameter("toy_price") == null) {	    	
			msg = "Digite um valor para o brinquedo.";
			error = true;
		}
		
		if (request.getParameter("toy_description").trim().equals("") || request.getParameter("toy_description") == null) {	    	
			msg = "A descricao nao pode ficar em branco.";
			error = true;
		}
		
		if (request.getParameter("toy_categories") == null) {	    	
			msg = "Selecione ao menos uma categoria.";
			error = true;
		}
		
		if (request.getParameter("toy_details").trim().equals("") || request.getParameter("toy_details") == null) {
			msg = "Detalhes nao pode ficar em branco.";
			error = true;
        }
		
		if (error == true) {
			String js;
			if (request.getParameter("action").equals("insertToy")) {
				js = "<script>window.location.href='ToyController?action=" + destiny + "&message1=" + msg + "';</script>";
			} else {
				js = "<script>window.location.href='ToyController?action=" + destiny + "&toy_code=" + request.getParameter("toy_code") + "&message1=" + msg + "';</script>";
			}

			request.setAttribute("message", js);
	    	forwardToPage(request, response, "index.jsp");
	    	
	    	return false;
		}
		
		return true;
	}
}