package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.model.Toy;
import br.edu.toycenter.util.ConnectionFactory;

public class ToyDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs; 
	private Toy toy;

	public ToyDAO() throws Exception {
		try {
			this.conn = ConnectionFactory.getConnection();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		}
	}
	
	public Toy getOneToy(Toy toy) throws Exception {
		try {
			
			ps = conn.prepareStatement("SELECT * FROM toy_table WHERE toy_code = ?");
			ps.setInt(1, toy.getToyCode());
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				this.toy = new Toy(toycode, image, name, price, description, details);
			}
			return this.toy;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}
	
	public List<Toy> getAllToy() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM toy_table");
			rs = ps.executeQuery();
			List<Toy> list = new ArrayList<Toy>();
			
			while (rs.next()) {
				
				int toycode = rs.getInt("toy_code");
				String image = rs.getString("toy_image");
				String name = rs.getString("toy_name");
				float price = rs.getFloat("toy_price");
				String description = rs.getString("toy_description");
				String details = rs.getString("toy_details");
				
				list.add(new Toy(toycode, image, name, price, description, details));
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

	public void insertToy(Toy toy) throws Exception {
		if (toy == null)
			throw new Exception("The value don't can be null");
		try {
			String SQL = "INSERT INTO toy_table "
				       + "(toy_code, toy_image, toy_name, toy_price, toy_description, toy_details) "
					   + "VALUES (?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, toy.getToyCode());
			ps.setString(2, toy.getToyImage());
			ps.setString(3, toy.getToyName());
			ps.setFloat(4, toy.getToyPrice());
			ps.setString(5, toy.getToyDescription());
			ps.setString(6, toy.getToyDetails());
			
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void updateToy(Toy toy) throws Exception {
		if (toy == null)
			throw new Exception("The value don't can be null");
		try {
			String SQL = "UPDATE toy_table "
				   	   + "SET toy_image = ?, toy_name = ?, toy_price = ?, toy_description = ?, toy_details = ? "
					   + "WHERE toy_code = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setString(1, toy.getToyImage());
			ps.setString(2, toy.getToyName());
			ps.setFloat(3, toy.getToyPrice());
			ps.setString(4, toy.getToyDescription());
			ps.setString(5, toy.getToyDetails());
			ps.setInt(6, toy.getToyCode());
				
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void deleteToy(Toy toy) throws Exception {
		if (toy == null)
			throw new Exception("The value don't can be null");
		try {
			String SQL = "DELETE FROM toy_table WHERE toy_code = ?";
			ps = conn.prepareStatement(SQL);
			ps.setInt(1, toy.getToyCode());
			
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
}