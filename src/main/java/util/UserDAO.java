package util;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import util.SingletonConnection;
import metier.User;

public final class UserDAO {
	
	  private static UserDAO instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new UserDAO();
	  }
	  
	  public final static UserDAO getInstance() { return instance; }
	  
	  private UserDAO() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
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
	  
	  public static ArrayList<User> getAllUsers() throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM user;";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  listUser.add(new User(rs.getString("name"),rs.getString("firstName"),"Admin"));
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listUser;   
	  }
	  
	  
		
	
}
