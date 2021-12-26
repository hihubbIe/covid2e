package util;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
	  
	  public static boolean checkPseudo(String login) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM user WHERE login = '"+login+"'";
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
	      String requete = "SELECT user.name as name,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role;";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  listUser.add(new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name")));
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listUser;   
	  }
	  
	  public static boolean insertUser(int id, User user,String mdp) {
		  Date date = user.getAnniversaire();  
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");  
		  String strDate = dateFormat.format(date);  
		  String SQL = "INSERT INTO user(id,login,password,name,firstName,birthday,role)"
	                + "VALUES('"+id+"','"+user.getPseudo()+"','"+mdp+"','"+user.getName()+"','"+user.getPrenom()+"','"+strDate+"','1')";
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static int maxIdUser() {
		  ResultSet rs = null;
		  int max_id=-1;
		  String requete_id = "SELECT MAX(id) as id FROM user LIMIT 1";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete_id);
			
	    	  while (rs.next()) {
	    		  max_id=rs.getInt("id");
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      
	      if (max_id != -1) max_id+=1;
	      return max_id;  
	  }
	  
	  
		
	
}
