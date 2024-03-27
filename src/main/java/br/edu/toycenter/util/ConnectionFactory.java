package br.edu.toycenter.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionFactory {
	private static final String classDriver = "com.mysql.jdbc.Driver";
	private static final String url = "jdbc:mysql://localhost:3306/toy_center";
	private static final String user = "root";
	private static final String password = "password";
	
	public static Connection getConnection() throws Exception {
		Connection conn = null;
		try {
			Class.forName(classDriver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			throw new SQLException("SQL error: " + e.getMessage());
		} catch (Exception e) {
			throw new Exception("Unexpected error: " + e.getMessage());
		}
		return conn;
	}
	
	public static void closeConnection(Connection conn, Statement stmt, ResultSet rs) throws Exception{
		close(conn, stmt, rs);
	}
	
	public static void closeConnection(Connection conn, Statement stmt) throws Exception {
		close(conn, stmt, null);
	}
	
	public static void closeConnection(Connection conn) throws Exception {
		close(conn, null, null);
	}
	
	public static void close(Connection conn, Statement stmt, ResultSet rs) throws Exception {
		try {
			if (rs != null ) rs.close();
			if (stmt != null) stmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			throw new SQLException("Unexpected error: " + e.getMessage());
		}
	}
}