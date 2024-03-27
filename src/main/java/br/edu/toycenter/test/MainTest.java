package br.edu.toycenter.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import br.edu.toycenter.dao.ToyDAO;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.util.ConnectionFactory;

public class MainTest {
	public static void main(String[] args) {
		Connection conn = null;
		
		try {
			conn = ConnectionFactory.getConnection();
			if (!conn.isClosed()) System.out.println("Connected.");
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
		Toy toy = new Toy(1243, "urlimagem", "nomeproduto", 123.00f, "um produto chique", "produto pequeno"); 
		
		try {
			ToyDAO toydao = new ToyDAO();
			toydao.insertToy(toy);
			System.out.println("Inserted.");
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
		toy = new Toy(1142, "urlimagem1", "nomeproduto1", 123.40f, "um produto chique1", "produto pequeno1"); 
		
		try {
			ToyDAO toydao = new ToyDAO();
			toydao.updateToy(toy);
			System.out.println("Uptaded.");
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
		toy = new Toy(1112); 
		
		try {
			ToyDAO toydao = new ToyDAO();
			toydao.deleteToy(toy);
			System.out.println("Deleted.");
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
		toy = new Toy(1142); 
	
			
		try {
			ToyDAO toydao = new ToyDAO();
			toy = toydao.getOneToy(toy);
			System.out.println(toy);
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
		System.out.println();

		
		try {
			ToyDAO toydao = new ToyDAO();
			List<Toy> listToy = toydao.getAllToy();
			for (Toy t : listToy) {
				System.out.println(t);
			}
		} catch (SQLException e) {
			System.out.print(e);
		} catch (Exception e) {
			System.out.print(e);
		}
		
	}
}