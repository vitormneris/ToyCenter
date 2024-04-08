package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.model.ToyCategory;
import br.edu.toycenter.util.ConnectionFactory;

public class ToyCategoryDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 
	Toy toy;

	public ToyCategoryDAO() throws Exception {
		try {
			this.conn = ConnectionFactory.getConnection();
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - tente novamente mais tarde.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - tente novamente mais tarde.");
		}
	}
	
	public List<ToyCategory> getAllToyCategory() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM toy_category");
			rs = ps.executeQuery();
			List<ToyCategory> list = new ArrayList<>();

			while (rs.next()) {
				int toyCode = rs.getInt("toy_code_fk");
				int categoryCode = rs.getInt("category_code_fk");
				list.add(new ToyCategory(toyCode, categoryCode));
			}
			return list;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar as relações entre brinquedo e categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar as relações entre brinquedo e categoria.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public Boolean toyCategoryInsert(Toy toy, Category category) throws Exception {
		if (toy == null && category == null)
			throw new Exception("The value don't can be null");
		try {
			String SQL = "INSERT INTO toy_category (toy_code_fk, category_code_fk) VALUES (?, ?)";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, toy.getToyCode());
			ps.setInt(2, category.getCategoryCode());
			
			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível relacionar o brinquedos com a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível relacionar o brinquedo com a categoria.");
		}
	}
	
	public Boolean toyCategoryDelete(Toy toy) throws Exception {
		if (toy == null)
			throw new Exception("The value don't can be null");
		try {		
			String SQL = "DELETE FROM toy_category WHERE toy_code_fk = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, toy.getToyCode());
			
			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível deletar a relacão do brinquedo com a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível deletar a relacão do brinquedo com a categoria.");
		}
	}
	
	public Boolean toyCategoryDelete(Category category) throws Exception {
		if (category == null)
			throw new Exception("The value don't can be null");
		try {
			
			String SQL = "DELETE FROM toy_category WHERE category_code_fk = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, category.getCategoryCode());
			
			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível deletar a relacão do brinquedo com a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível deletar a relacão do brinquedo com a categoria.");
		}
	}
	
	public List<Category> getAllCategories(Toy toy) throws Exception {
		try {
			String query = "SELECT DISTINCT c.category_code, c.category_name, c.category_image "
					+ "FROM category_table c "
					+ "INNER JOIN toy_category tc ON tc.category_code_fk = c.category_code "
					+ "INNER JOIN toy_table t ON tc.toy_code_fk = ?;";
			ps = conn.prepareStatement(query);
			ps.setInt(1, toy.getToyCode());
			rs = ps.executeQuery();
			
			List<Category> categories = new ArrayList<>();
			
			while (rs.next()) {
				int categoryCode = rs.getInt("category_code");
				String categoryName = rs.getString("category_name");
				String categoryImage = rs.getString("category_image");

				Category category = new Category(categoryCode);
				
				category = new Category(categoryCode, categoryName, categoryImage);
				categories.add(category);
			}
			
			return categories; 	
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar as relações entre brinquedo e categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar as relações entre brinquedo e categoria.");
		}
	}
	
	public List<Toy> getAllToyByCategory(Category category) throws Exception {
		try {
			String query = "SELECT DISTINCT t.toy_code, t.toy_image, t.toy_name, t.toy_brand, t.toy_price, t.toy_description, t.toy_details "
					     + "FROM toy_table t " 
				       	 + "INNER JOIN toy_category tc ON tc.toy_code_fk = t.toy_code "
					     + "INNER JOIN category_table c ON tc.category_code_fk = ?";
			ps = conn.prepareStatement(query);
			ps.setInt(1, category.getCategoryCode());
			rs = ps.executeQuery();
			
			List<Toy> toys = new ArrayList<>();

			while (rs.next()) {
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				String brand = rs.getString("toy_brand");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				toy = new Toy(toycode);
				toy = new Toy(toycode, image, name, brand, price, description, details);
				toys.add(toy);
			}
			
			return toys; 	
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar as relações entre brinquedo e categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar as relações entre brinquedo e categoria.");
		}
	}
	
	public boolean deleteEspecifyToy(Category category) throws Exception {
		try {
			ToyDAO td = new ToyDAO();
			List<Toy> listToy = td.getAllToy();
			for (Toy toy : listToy) {
				if (toy.getToyCategories().size() == 0) {
					td = new ToyDAO();
					td.deleteToy(toy, false);
				}
			}
			return true;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível deletar a relação entre o brinquedo e categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível deletar a relação entre o brinquedo e categoria.");
		}
			
	}
	
}