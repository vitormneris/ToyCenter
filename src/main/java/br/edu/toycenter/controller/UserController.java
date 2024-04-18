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

import br.edu.toycenter.dao.UserDAO;
import br.edu.toycenter.model.User;

@WebServlet("/UserController")
@MultipartConfig
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
        HttpSession session = request.getSession(false); 

		if (!(session != null && session.getAttribute("loggedIn") != null && (boolean) session.getAttribute("loggedIn")))
			forwardToPage(request, response, "jsp/login.jsp");
		
		try {
    		UserDAO userdao = new UserDAO();
    		User user = null;
    		
			if (action.equals("getAllUser")) {
				getAllUser(request, response);
				
			} else if (action.equals("updateUser")) {
        		user = userdao.getOneUser(new User(Integer.parseInt(request.getParameter("user_code"))));
        		session = request.getSession(true);
        		session.setAttribute("user", user);
	            forwardToPage(request, response, "jsp/user/updateUser.jsp");
	            
			} else if (action.equals("deleteUser")) {
        		user = userdao.getOneUser(new User(Integer.parseInt(request.getParameter("user_code"))));
        		session = request.getSession(true);
        		session.setAttribute("user", user);
	            forwardToPage(request, response, "jsp/user/deleteUser.jsp");
	            
		    }  else if (action.equals("insertUser")) {
	            forwardToPage(request, response, "jsp/user/insertUser.jsp");
		    } else if (action.equals("logOut")) {
		    	loginOutUser(request, response);
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
	        	case "loginUser":
	    		    loginUser(request, response);
	    		    break;
            	case "getOneUser":
    				getOneUser(request, response);
    				break;
            	case "insertUser":
    				insertUser(request, response);
    				break;
            	case "updateUser":
	        		updateUser(request, response);
                    break;
            	case "deleteUser":
                    deleteUser(request, response);
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
    
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO userDAO = new UserDAO();
		
		if (request.getParameter("user_email") == null || request.getParameter("user_password") == null)
			throw new Exception("E-mail and password can not be null");
		
		User user = new User(request.getParameter("user_email"), request.getParameter("user_password"));
		if (userDAO.loginUser(user)) {
			
	        String redirectScript = "<script>window.location.href='ToyController?action=getAllToyAdm';</script>";
			HttpSession session = request.getSession(true);
			session.setAttribute("loggedIn", true);
			request.setAttribute("message", redirectScript);

			forwardToPage(request, response, "index.jsp");
		} else {	    	

			request.setAttribute("message1", "E-mail ou senha errado");

			forwardToPage(request, response, "jsp/login.jsp");
		}
    }
    
    private void loginOutUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null) 
            session.invalidate();
		forwardToPage(request, response, "index.jsp");
	}
	
    private void getAllUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		UserDAO userDAO = new UserDAO();
		List<User> list = userDAO.getAllUser();
		
		if (list != null) {
			request.setAttribute("userList", list);
			
			forwardToPage(request, response, "jsp/user/getAllUser.jsp");
		} else {
	    	request.setAttribute("message", "Users not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void getOneUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		UserDAO userDAO = new UserDAO();
		User user = new User(Integer.parseInt(request.getParameter("user_code")));
		user = userDAO.getOneUser(user);
		
		if (user != null) {
			request.setAttribute("user", user);
	    	forwardToPage(request, response, "jsp/user/getOneUser.jsp");
		} else {
	    	request.setAttribute("message", "User not found");
        	forwardToPage(request, response, "jsp/error.jsp");
		}
	}
	
	private void insertUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		UserDAO userDAO = new UserDAO();
		User user = createObjectUser(request, response);
		
		String msg =  userDAO.insertUser(user) ? "User inserted sucessfully" : "Unable to create user";
	    request.setAttribute("message", msg);
	    String text = request.getParameter("login");
	    if (text != null) 
    		if (text.equals("true")) 
            	forwardToPage(request, response, "index.jsp");
	    
		String js = "<script>window.location.href='UserController?action=getAllUser'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
    }
	
	private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		UserDAO userDAO = new UserDAO();
		User user = createObjectUser(request, response);

		String msg =  userDAO.updateUser(user) ? "User updated sucessfully" : "Unable to update user";
	    request.setAttribute("message", msg);

		String js = "<script>window.location.href='UserController?action=getAllUser'</script>";
		
		request.setAttribute("message", js);
    	forwardToPage(request, response, "index.jsp");
	} 
	
	private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		UserDAO userDAO = new UserDAO();
		User user = new User(Integer.parseInt(request.getParameter("user_code")));
		
		if (userDAO.deleteBlock()) {
			String msg = "Não é possível deletar o último usuário";
			request.setAttribute("message", msg);
			getAllUser(request, response);
		} else {
			String msg =  userDAO.deleteUser(user) ? "User deleted sucessfully" : "Unable to delete user";
		    request.setAttribute("message", msg);
			getAllUser(request, response);
		}
	}
	
	private User createObjectUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		User user = new User();
		try {
			if (!(request.getParameter("action").equals("insertUser"))) {
				if (!inputCheck(request, response, "updateUser")) return null;
				user.setUserCode(Integer.parseInt(request.getParameter("user_code")));
			} else {
				if (!inputCheck(request, response, "insertUser")) return null;
			}
			
			user.setUserName(request.getParameter("user_name"));
			user.setUserEmail(request.getParameter("user_email"));
			user.setUserPassword(request.getParameter("user_password"));

		} catch (Exception e) {
	    	request.setAttribute("message", e.getMessage());
        	forwardToPage(request, response, "jsp/error.jsp");
		}
		return user;
	}
	
	private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher(page);
		rd.forward(request, response);
	}
	
	private boolean inputCheck(HttpServletRequest request, HttpServletResponse response, String destiny) throws ServletException, IOException {
		boolean error = false;
		String msg = "";
		
		if (request.getParameter("user_name").trim().equals("") || request.getParameter("user_name") == null) {	    
			msg = "O nome nao pode ficar em branco.";
			error = true;
		}
		
		if (request.getParameter("user_email").trim().equals("") || request.getParameter("user_email") == null) {	    	
			msg = "O e-mail nao pode ficar em branco.";
			error = true;
		}
		
		
		if (request.getParameter("user_password").trim().equals("") || request.getParameter("user_password") == null) {	    	
			msg = "A senha nao pode ficar em branco.";
			error = true;
		}
		
		if (error == true) {
			String js;
			if (request.getParameter("action").equals("insertUser")) {
				js = "<script>window.location.href='UserController?action=" + destiny + "&message1=" + msg + "';</script>";
			} else {
				js = "<script>window.location.href='UserController?action=" + destiny + "&user_code=" + request.getParameter("toy_code") + "&message1=" + msg + "';</script>";
			}

			request.setAttribute("message", js);
	    	forwardToPage(request, response, "index.jsp");
	    	
	    	return false;
		}
		
		return true;
	}
}