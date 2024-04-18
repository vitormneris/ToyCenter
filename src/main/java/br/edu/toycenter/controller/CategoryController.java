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
import br.edu.toycenter.model.Category;

@WebServlet("/CategoryController")
@MultipartConfig
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action"); 
		
		try {
			if (action.equals("getAllCategory")) {
				getAllCategory(request, response, false);
			} else if (action.equals("updateCategory")) {
				screenBlock(request, response);
        		CategoryDAO categorydao = new CategoryDAO();
        		Category category = categorydao.getOneCategory(new Category(Integer.parseInt(request.getParameter("category_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("category", category);
	            forwardToPage(request, response, "jsp/category/updateCategory.jsp");
			} else if (action.equals("deleteCategory")) {
				screenBlock(request, response);
        		CategoryDAO categorydao = new CategoryDAO();
        		Category category = categorydao.getOneCategory(new Category(Integer.parseInt(request.getParameter("category_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("category", category);
	            forwardToPage(request, response, "jsp/category/deleteCategory.jsp");
		    } else if (action.equals("getOneCategory")) {
		    	getOneCategory(request, response);
		    } else if (action.equals("getAllCategoryAdm")) {
				screenBlock(request, response);
				getAllCategory(request, response, true);
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
        
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "index.jsp");
        
        try {          
            switch (action) {
            	case "getOneCategory":
    				getOneCategory(request, response);
    				break;
            	case "insertCategory":
    				insertCategory(request, response);
    				break;
            	case "updateCategory":
	        		updateCategory(request, response);
                    break;
            	case "deleteCategory":
                    deleteCategory(request, response);
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
	
    private void getAllCategory(HttpServletRequest request, HttpServletResponse response, boolean adm) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		List<Category> list = td.getAllCategoryWithToy(true);
		
		request.setAttribute("categoryList", list);

		String msg = (adm) ? "jsp/category/getAllCategoryAdm.jsp" : "jsp/category/getAllCategory.jsp";
	    forwardToPage(request, response, msg);
	}
	
	private void getOneCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		Category category = new Category(Integer.parseInt(request.getParameter("category_code")));
		category = td.getOneCategory(category);
		
		if (category != null) {
			request.setAttribute("category", category);

	    	forwardToPage(request, response, "jsp/category/getAllToyByCategory.jsp");
		} else {
	    	request.setAttribute("message", "Category not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void insertCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		Category category = createObjectCategory(request, response);
		
		if (td.insertCategory(category)) {
	    	request.setAttribute("message", "Category inserted sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to create category");
		}
    	
		String js = "<script>window.location.href='CategoryController?action=getAllCategoryAdm'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
    }
	
	private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		Category category = createObjectCategory(request, response);

		if (td.updateCategory(category)) {
	    	request.setAttribute("message", "Category updated sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to update category");
		}
		
		String js = "<script>window.location.href='CategoryController?action=getAllCategoryAdm'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
    } 
	
	private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO cd = new CategoryDAO();
		Category category = new Category(Integer.parseInt(request.getParameter("category_code")));
		
		if (cd.deleteCategory(category)) {
	    	request.setAttribute("message", "Category deleted sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to delete category");
		}
		
		getAllCategory(request, response, true);
	}
	
	private Category createObjectCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		Category category = new Category();
		try {
			
			if (!(request.getParameter("action").equals("insertCategory"))) {
				if (!inputCheck(request, response, "updateCategory")) return null;
				category.setCategoryCode(Integer.parseInt(request.getParameter("category_code")));
			} else {
				if (!inputCheck(request, response, "insertCategory")) return null;
			}
			
			category.setCategoryName(request.getParameter("category_name"));	
			category.setCategoryImage(uploadImage(request, response));

		} catch (Exception e) {
	    	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
		}
		return category;
	}
	
	private String uploadImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = "/home/vitor/eclipse-workspace/ToyCenter/src/main/webapp/image/dataBaseImageCategory";		
		for(Part part : request.getParts()) {
			if (part.getName().equals("category_image") && part.getSize() > 0) {
				part.write(path + File.separator + part.getSubmittedFileName());
				return "image/dataBaseImageCategory" + File.separator + part.getSubmittedFileName();
			}
		}
		
		CategoryDAO td = new CategoryDAO();
		return td.getOneCategory(new Category(Integer.parseInt(request.getParameter("category_code")))).getCategoryImage();
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
	
	private void screenBlock(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
	}
	
	private boolean inputCheck(HttpServletRequest request, HttpServletResponse response, String destiny) throws ServletException, IOException {
		boolean error = false;
		String msg = "";
		
		if (request.getParameter("category_name").trim().equals("") || request.getParameter("category_name") == null) {	    
			msg = "O nome nao pode ficar em branco.";
			error = true;
		}
		
		if (request.getParameter("action").equals("insertCategory")) {
			boolean img = false;
			for(Part part : request.getParts()) {
				if (part.getName().equals("category_image") && part.getSize() > 0) {
					img = true;
				}
			}
			if (!img) {
				msg = "Envie uma imagem";
				error = true;			
			}
		}
		
		if (error == true) {
			String js;
			if (request.getParameter("action").equals("insertCategory")) {
				js = "<script>window.location.href='CategoryController?action=" + destiny + "&message1=" + msg + "';</script>";
			} else {
				js = "<script>window.location.href='CategoryController?action=" + destiny + "&category_code=" + request.getParameter("category_code") 
				+ "&message1=" + msg + "';</script>";
			}

			request.setAttribute("message", js);
	    	forwardToPage(request, response, "index.jsp");
	    	
	    	return false;
		}
		
		return true;
	}
}