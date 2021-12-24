package util;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public final class DBAccess {
	
	  private static DBAccess instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  private static String DB_USER = "root";
	  private static String DB_PASS = "";
	  private static String DB_ADRESS = "jdbc:mysql://localhost:3306/covid";
	  
	  static {
	    instance = new DBAccess();
	  }
	  
	  public final static DBAccess getInstance() { return instance; }
	  
	  private DBAccess() {
		  try {
	           Class.forName("com.mysql.jdbc.Driver");  
	           con = DriverManager.getConnection(DB_ADRESS,DB_USER,DB_PASS);
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        } catch (ClassNotFoundException e) {
	        	System.out.println(e);
			}
	  }
	  
	  public static boolean checkAccount(String login, String password) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM user WHERE login = '"+login+"' AND password='"+password+"';";
	      try {	  
	    	  
	    	  rs = stmt.executeQuery(requete);
			
			  if (rs.next() == false) {
		        } else {
		          do {
		            return true;
		          } while (rs.next());
		        }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
		
	
}
