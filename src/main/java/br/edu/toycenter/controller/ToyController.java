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

import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.model.Toy;

@WebServlet("/ToyController")
@MultipartConfig
public class ToyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			if (action.equals("getAllToy")) {
				getAllToy(request, response);
			} else if (action.equals("updateToy")) {
        		ToyDAO toydao = new ToyDAO();
        		Toy toy = toydao.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("toy", toy);
	            forwardToPage(request, response, "jsp/updateToy.jsp");
			} else if (action.equals("deleteToy")) {
        		ToyDAO toydao = new ToyDAO();
        		Toy toy = toydao.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code"))));
        		HttpSession session = request.getSession(true);
        		session.setAttribute("toy", toy);
	            forwardToPage(request, response, "jsp/deleteToy.jsp");
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
	
    private void getAllToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		List<Toy> list = td.getAllToy();
		
		if (list != null) {
			request.setAttribute("toyList", list);
	    	forwardToPage(request, response, "jsp/getAllToy.jsp");
		} else {
	    	request.setAttribute("message", "Toys not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void getOneToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy(Integer.parseInt(request.getParameter("toy_code")));
		toy = td.getOneToy(toy);
		
		if (toy != null) {
			request.setAttribute("toy", toy);
	    	forwardToPage(request, response, "jsp/getOneToy.jsp");
		} else {
	    	request.setAttribute("message", "Toy not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void insertToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = createObjectToy(request, response);
		
		if (td.insertToy(toy)) {
	    	request.setAttribute("message", "Toy inserted sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to create toy");
		}
    	
		getAllToy(request, response);
	}
	
	private void updateToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = createObjectToy(request, response);

		if (td.updateToy(toy)) {
	    	request.setAttribute("message", "Toy updated sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to update toy");
		}
		
		getOneToy(request, response);
	} 
	
	private void deleteToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy(Integer.parseInt(request.getParameter("toy_code")));
		
		if (td.deleteToy(toy)) {
	    	request.setAttribute("message", "Toy deleted sucessfully");
		} else {
	    	request.setAttribute("message", "Unable to delete toy");
		}
		
		getAllToy(request, response);
	}
	
	private Toy createObjectToy(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		Toy toy = new Toy();
		try {
			toy.setToyCode(Integer.parseInt(request.getParameter("toy_code")));
			toy.setToyImage(uploadImage(request, response));			
			toy.setToyName(request.getParameter("toy_name"));
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
	
	public String uploadImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String path = "/home/vitor/eclipse-workspace/ToyCenter/src/main/webapp/image";		
		for(Part part : request.getParts()) {
			if (part.getName().equals("toy_image") && part.getSize() > 0) {
				part.write(path + File.separator + part.getSubmittedFileName());
				return "image" + File.separator + part.getSubmittedFileName();
			}
		}
		
		ToyDAO td = new ToyDAO();
		return td.getOneToy(new Toy(Integer.parseInt(request.getParameter("toy_code")))).getToyImage();
	}
}