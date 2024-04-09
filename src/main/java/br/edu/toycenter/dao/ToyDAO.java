package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.model.Category;
import br.edu.toycenter.model.Toy;
import br.edu.toycenter.util.ConnectionFactory;

public class ToyDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 

	public ToyDAO() throws Exception {
		try {
			this.conn = ConnectionFactory.getConnection();
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - tente novamente mais tarde.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - tente novamente mais tarde.");
		}
	}
	
	public List<Toy> getAllToy() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM toy_table");
			rs = ps.executeQuery();
			List<Toy> list = new ArrayList<>();
			ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();
			boolean toyStatus = false;

			while (rs.next()) {
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				String brand = rs.getString("toy_brand");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				Toy toy = new Toy(toycode);
				list.add(new Toy(toycode, image, name, brand, price, description, details, toyCategoryDAO.getAllCategories(toy)));
				toyStatus = true;
			}
			
			if (!toyStatus) 
				return null;
			return list;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar os brinquedos.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar os brinquedos.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public Toy getOneToy(Toy toy) throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM toy_table WHERE toy_code = ?");
			ps.setInt(1, toy.getToyCode());
			rs = ps.executeQuery();
			ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();
			boolean toyStatus = false;

			while (rs.next()) {
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				String brand = rs.getString("toy_brand");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				toy = new Toy(toycode, image, name, brand, price, description, details, toyCategoryDAO.getAllCategories(toy));
				toyStatus = true;
			}
			
			if (!toyStatus) 
				return null;
			return toy;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar o brinquedo.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar o brinquedo.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public Toy getLastToy() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM toy_table WHERE toy_code = LAST_INSERT_ID()");
			rs = ps.executeQuery();
			Toy toy = null;
			boolean toyStatus = false;

			while (rs.next()) {
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				String brand = rs.getString("toy_brand");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				toy = new Toy(toycode, image, name, brand, price, description, details);
				toyStatus = true;
			}
			
			if (!toyStatus) 
				return null;
			return toy;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível encontrar o brinquedo." + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível encontrar o brinquedo.");
		} 
	}

	public Boolean insertToy(Toy toy) throws Exception {
		if (toy == null)
			throw new Exception("The value don't can be null");
		try {
			ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();
			
			String SQL = "INSERT INTO toy_table "
				       + "(toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) "
					   + "VALUES(?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(SQL);
			
			ps.setString(1, toy.getToyImage());
			ps.setString(2, toy.getToyName());
			ps.setString(3, toy.getToyBrand());
			ps.setFloat(4, toy.getToyPrice());
			ps.setString(5, toy.getToyDescription());
			ps.setString(6, toy.getToyDetails());
			
			if (ps.executeUpdate() > 0) {	
				for (Category category : toy.getToyCategories()) 
					if (!toyCategoryDAO.toyCategoryInsert(getLastToy(), category)) 
						return false;
				return true;
			} 
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível inserir o brinquedo." + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível inserir o brinquedo.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean updateToy(Toy toy) throws Exception {
		if (toy == null) {
			throw new Exception("The value don't can be null");
		}
		try {
			ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();

			String SQL = "UPDATE toy_table "
				   	   + "SET toy_image = ?, toy_name = ?, toy_brand = ?, toy_price = ?, toy_description = ?, toy_details = ? "
					   + "WHERE toy_code = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setString(1, toy.getToyImage());
			ps.setString(2, toy.getToyName());
			ps.setString(3, toy.getToyBrand());
			ps.setFloat(4, toy.getToyPrice());
			ps.setString(5, toy.getToyDescription());
			ps.setString(6, toy.getToyDetails());
			ps.setInt(7, toy.getToyCode());
				
			if (ps.executeUpdate() > 0) {
				if (toyCategoryDAO.toyCategoryDelete(toy)) {
					for (Category category : toy.getToyCategories()) 
						if (!toyCategoryDAO.toyCategoryInsert(toy, category)) 
							return false;
					return true;
				}
			}
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível atualizar o brinquedo.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível atualizar o brinquedo.");
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean deleteToy(Toy toy, boolean toyCategory) throws Exception {
		try {
			if (toyCategory) {
				ToyCategoryDAO toyCategoryDAO = new ToyCategoryDAO();
				if (!toyCategoryDAO.toyCategoryDelete(toy)) throw new SQLException("SQL error: ");
			}
			
			String SQL = "DELETE FROM toy_table WHERE toy_code = ?";

			ps = conn.prepareStatement(SQL);

			ps.setInt(1, toy.getToyCode());
			
			if (ps.executeUpdate() > 0) {
				return true;
			}
			return false;
		} catch (SQLException e) {
			throw new SQLException("Erro no banco de dados - Não foi possível deletar o brinquedo.");
		} catch (Exception e) {
			throw new Exception("Erro inesperado - Não foi possível deletar o brinquedo.");
		} finally {
			if (toyCategory) {
				ConnectionFactory.closeConnection(conn, ps);
			}
		}
	}
}