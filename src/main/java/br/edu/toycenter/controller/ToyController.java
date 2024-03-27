package br.edu.toycenter.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.model.Toy;

@WebServlet("/ToyController")
public class ToyController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			if (action.equals("getAllToy")) {
				getAllToy(request, response);
			}
 		} catch (Exception e) {
			System.out.print(e.getMessage());
		}
	}
	
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action.equals("insertToy")) {
				insertToy(request, response);
            } else if (action.equals("getOneToy")) {
				getOneToy(request, response);
			} else if (action.equals("updateToy")) {
                updateToy(request, response);
            } else if (action.equals("deleteToy")) {
                deleteToy(request, response);
            }
        } catch (Exception e) {
			System.out.print(e.getMessage());
        }
    }
	
	protected void getAllToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		List<Toy> list = td.getAllToy();
		
		request.setAttribute("toyList", list);
		RequestDispatcher rd = request.getRequestDispatcher("jsp/getAllToy.jsp");
		rd.forward(request, response);
	}
	
	protected void getOneToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy(Integer.parseInt(request.getParameter("toy_code")));
		
		toy = td.getOneToy(toy);
		
		request.setAttribute("toy", toy);
		RequestDispatcher rd = request.getRequestDispatcher("jsp/getOneToy.jsp");
		rd.forward(request, response);	
	}
	
	protected void insertToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy();
		
		toy.setToyCode(Integer.parseInt(request.getParameter("toy_code")));
		toy.setToyImage(request.getParameter("toy_image"));
		toy.setToyName(request.getParameter("toy_name"));
		toy.setToyPrice(Float.parseFloat(request.getParameter("toy_price")));
		toy.setToyDescription(request.getParameter("toy_description"));
		toy.setToyDetails(request.getParameter("toy_details"));

		td.insertToy(toy);
	}
	
	protected void updateToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy();
		
		toy.setToyCode(Integer.parseInt(request.getParameter("toy_code")));
		toy.setToyImage(request.getParameter("toy_image"));
		toy.setToyName(request.getParameter("toy_name"));
		toy.setToyPrice(Float.parseFloat(request.getParameter("toy_price")));
		toy.setToyDescription(request.getParameter("toy_description"));
		toy.setToyDetails(request.getParameter("toy_details"));
		
		td.updateToy(toy);	
	}
	
	protected void deleteToy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
		ToyDAO td = new ToyDAO();
		Toy toy = new Toy();
		
		toy.setToyCode(Integer.parseInt(request.getParameter("toy_code")));
		
		td.deleteToy(toy);
	}
}