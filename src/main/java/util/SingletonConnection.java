package util;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SingletonConnection {
	private static Connection connection;
	private static String DB_USER = "root";
	private static String DB_PASS = "";
	private static String DB_ADRESS = "jdbc:mysql://localhost:3306/covid";
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection= DriverManager.getConnection
					(DB_ADRESS,DB_USER,DB_PASS);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}

	public static Connection getConnection() {
		return connection;
	}
	

}