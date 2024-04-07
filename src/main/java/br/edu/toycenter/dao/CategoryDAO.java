package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.model.Category;
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
			throw new SQLException("Erro no banco de dados - tente novamente mais tarde.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - tente novamente mais tarde.");
		}
	}
	
	public Category getOneCategory(Category category) throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM category_table WHERE category_code = ?");
			ps.setInt(1, category.getCategoryCode());
			rs = ps.executeQuery();
			boolean categoryStatus = false;
			ToyCategoryDAO tcd = new ToyCategoryDAO();
			
			while (rs.next()) {
				int categorycode = rs.getInt("category_code");
				String name = rs.getString("category_name");
				category = new Category(categorycode, name, tcd.getAllToyByCategory(category));
				categoryStatus = true;
			}
			
			if (!categoryStatus) {
				return null;
			}
			
			return category;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar a categoria.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public List<Category> getAllCategoryWithToy(boolean yes) throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM category_table");
			rs = ps.executeQuery();
			List<Category> list = new ArrayList<>();
			ToyCategoryDAO tcd = new ToyCategoryDAO();
			boolean categoryStatus = false;

			while (rs.next()) {
				int categoryCode = rs.getInt("category_code");
				String name = rs.getString("category_name");
				Category category = new Category(rs.getInt("category_code"));
				if (yes) {
					list.add(new Category(categoryCode, name, tcd.getAllToyByCategory(category)));
				} else {
					list.add(new Category(categoryCode, name));

				}
				categoryStatus = true;
			}
			
			if (!categoryStatus) {
				return null;
			}
			
			return list;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar as categorias.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar as categorias.");
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
			throw new SQLException("Erro no banco de dados - Não foi possível inserir a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível inserir a categoria.");
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
			throw new SQLException("Erro no banco de dados - Não foi possível atualizar a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível atualizar a categoria.");
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
			throw new SQLException("Erro no banco de dados - Não foi possível deletar a categoria.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível deletar a categoria.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	
}