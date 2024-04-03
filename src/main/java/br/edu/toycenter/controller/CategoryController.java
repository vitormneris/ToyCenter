package br.edu.toycenter.controller;

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

import br.edu.toycenter.dao.CategoryDAO;
import br.edu.toycenter.dao.ToyDAO;
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
				getAllCategory(request, response);
			} else if (action.equals("updateCategory")) {
        		CategoryDAO categorydao = new CategoryDAO();
        		Category category = categorydao.getOneCategory(new Category(Integer.parseInt(request.getParameter("category_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("category", category);
	            forwardToPage(request, response, "jsp/category/updateCategory.jsp");
			} else if (action.equals("deleteCategory")) {
        		CategoryDAO categorydao = new CategoryDAO();
        		Category category = categorydao.getOneCategory(new Category(Integer.parseInt(request.getParameter("category_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("category", category);
	            forwardToPage(request, response, "jsp/category/deleteCategory.jsp");
		    } else if (action.equals("getOneCategory")) {
		    	getOneCategory(request, response);
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
	
    private void getAllCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		List<Category> list = td.getAllCategory();
		
		if (list != null) {
			request.setAttribute("categoryList", list);
	    	forwardToPage(request, response, "jsp/category/getAllCategory.jsp");
		} else {
	    	request.setAttribute("message", "Categorys not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void getOneCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		Category category = new Category(Integer.parseInt(request.getParameter("category_code")));
		category = td.getOneCategory(category);
		
		if (category != null) {
			request.setAttribute("category", category);
	    	forwardToPage(request, response, "jsp/category/getOneCategory.jsp");
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
    	
		getAllCategory(request, response);
	}
	
	private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO td = new CategoryDAO();
		Category category = createObjectCategory(request, response);

		if (td.updateCategory(category)) {
	    	request.setAttribute("message", "Category updated sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to update category");
		}
		
		getOneCategory(request, response);
	} 
	
	private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		CategoryDAO cd = new CategoryDAO();
		Category category = new Category(Integer.parseInt(request.getParameter("category_code")));
		
		if (cd.deleteCategory(category)) {
	    	request.setAttribute("message", "Category deleted sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to delete category");
		}
		
		getAllCategory(request, response);
	}
	
	private Category createObjectCategory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		Category category = new Category();
		try {
			category.setCategoryCode(Integer.parseInt(request.getParameter("category_code")));
			category.setCategoryName(request.getParameter("category_name"));	

		} catch (Exception e) {
	    	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
		}
		return category;
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
}