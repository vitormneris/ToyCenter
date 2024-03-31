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

public class CategoryDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 

	public CategoryDAO() throws Exception {
		try {
			this.conn = ConnectionFactory.getConnection();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		}
	}
	
	public Category getOneCategory(Category category) throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM category_table WHERE category_code = ?");
			ps.setInt(1, category.getCategoryCode());
			rs = ps.executeQuery();
			boolean categoryStatus = false;

			while (rs.next()) {
				int categorycode = rs.getInt("category_code");
				String name = rs.getString("category_name");
				category = new Category(categorycode, name);
				categoryStatus = true;
			}
			
			if (!categoryStatus) {
				return null;
			}
			
			return category;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public List<Category> getAllCategory() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM category_table");
			rs = ps.executeQuery();
			List<Category> list = new ArrayList<>();
			boolean categoryStatus = false;

			while (rs.next()) {
				int categorycode = rs.getInt("category_code");
				String name = rs.getString("category_name");

				list.add(new Category(categorycode, name));
				categoryStatus = true;
			}
			
			if (!categoryStatus) {
				return null;
			}
			
			return list;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}

	public Boolean insertCategory(Category category) throws Exception {
		if (category == null)
			throw new Exception("The value don't can be null");
		try {
			String SQL = "INSERT INTO category_table (category_code, category_name) VALUES (?, ?)";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, category.getCategoryCode());
			ps.setString(2, category.getCategoryName());

			
			if (ps.executeUpdate() > 0) {
				return true;
			} else {
				return false;
			} 
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean updateCategory(Category category) throws Exception {
		if (category == null) {
			throw new Exception("The value don't can be null");
		}
		try {
			String SQL = "UPDATE category_table SET category_name = ? WHERE category_code = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setString(1, category.getCategoryName());
			ps.setInt(2, category.getCategoryCode());
				
			if (ps.executeUpdate() > 0) {
				return true;
			} else {
				return false;
			} 
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean deleteCategory(Category category) throws Exception {
		try {		
			ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();
			boolean status = false;
			List<ToyCategory> list = toyCategoryDAO.getAllToyCategory();
			for (ToyCategory tc : list) {
				if (tc.getCategoryCode() == category.getCategoryCode()) {
					status = true;
					break;
				}
			}
			
			if (status) {
				System.out.println("sdfsdfds");
				toyCategoryDAO = new ToyCategoryDAO();
				if (!toyCategoryDAO.toyCategoryDelete(category)) throw new SQLException("SQL error");

				if (!toyCategoryDAO.deleteEspecifyToy(category)) throw new SQLException("SQL error");
			}
			
			String SQL = "DELETE FROM category_table WHERE category_code = ?";
			ps = conn.prepareStatement(SQL);
			ps.setInt(1, category.getCategoryCode());
			
			if (ps.executeUpdate() > 0) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	
}