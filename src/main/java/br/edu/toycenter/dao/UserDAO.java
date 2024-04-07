package br.edu.toycenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.toycenter.model.User;
import br.edu.toycenter.util.ConnectionFactory;

public class UserDAO {
	private Connection conn; 
	private PreparedStatement ps; 
	private ResultSet rs;

	public UserDAO() throws Exception {
		try {
			this.conn = ConnectionFactory.getConnection();
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		}
	}

	public List<User> getAllUser() throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM user_table");
			rs = ps.executeQuery();
			List<User> list = new ArrayList<>();
			boolean userStatus = false;

			while (rs.next()) {
				int userCode = rs.getInt("user_code");
				String userName = rs.getString("user_name");
				String userEmail = rs.getString("user_email");
				String userPassword = rs.getString("user_password");
				list.add(new User(userCode, userName, userEmail, userPassword));
				userStatus = true;
			}
			
			if (!userStatus) 
				return null;
			return list;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}

	public User getOneUser(User user) throws Exception {
		try {
			ps = conn.prepareStatement("SELECT * FROM user_table WHERE user_code = ?");
			ps.setInt(1, user.getUserCode());
			rs = ps.executeQuery();
			boolean userStatus = false;

			while (rs.next()) {
				int userCode = rs.getInt("user_code");
				String userName = rs.getString("user_name");
				String userEmail = rs.getString("user_email");
				String userPassword = rs.getString("user_password");
				user = new User(userCode, userName, userEmail, userPassword);
				userStatus = true;
			}
			
			if (!userStatus) 
				return null;
			return user;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}

	public Boolean insertUser(User user) throws Exception {
		if (user == null)
			throw new Exception("The value don't can be null");
		try {			
			String SQL = "INSERT INTO user_table "
				       + "(user_code, user_name, user_email, user_password) "
					   + "VALUES (?, ?, ?, ?)";
			ps = conn.prepareStatement(SQL);
			
			ps.setInt(1, user.getUserCode());
			ps.setString(2, user.getUserName());
			ps.setString(3, user.getUserEmail());
			ps.setString(4, user.getUserPassword());

			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean updateUser(User user) throws Exception {
		if (user == null) {
			throw new Exception("The value don't can be null");
		}
		try {
			String SQL = "UPDATE user_table "
				   	   + "SET user_name = ?, user_email = ?, user_password = ? "
					   + "WHERE user_code = ?";
			ps = conn.prepareStatement(SQL);
			
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getUserEmail());
			ps.setString(3, user.getUserPassword());
			ps.setInt(4, user.getUserCode());
				
			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean deleteUser(User user) throws Exception {
		try {
			String SQL = "DELETE FROM user_table WHERE user_code = ?";
			ps = conn.prepareStatement(SQL);
			ps.setInt(1, user.getUserCode());
			
			if (ps.executeUpdate() > 0) 
				return true;
			return false;
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		} finally {
			ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public Boolean loginUser(User user) throws SQLException {
		String SQL = "SELECT user_email, user_password FROM user_table";
		ps = conn.prepareStatement(SQL);
		rs = ps.executeQuery();

		while(rs.next()) {
			String emailBD = rs.getString("user_email");
			String passwordBD = rs.getString("user_password");
			if (emailBD.equals(user.getUserEmail())) 
				if (passwordBD.equals(user.getUserPassword())) 
					return true;
		}
		return false;
	}
}