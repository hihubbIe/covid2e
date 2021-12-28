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
	  
	  public static String checkRole(String login, String password) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM user WHERE login = '"+login+"' AND password='"+password+"';";
	      String role = "";
	      try {	  
	    	  
	    	  rs = stmt.executeQuery(requete);
	    	  while(rs.next()) {
	    		  role=rs.getString("role");
	    	  }
	      } catch (Exception e) {
	    	  e.printStackTrace();
	      }
	      return role;
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
	      String requete = "SELECT user.name as name,login,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role;";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user.setPseudo(rs.getString("login"));
	    		  listUser.add(user);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listUser;   
	  }
	  
	  public static User getUserByPseudo(String pseudo) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT user.name as name,birthday,login,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role AND login='"+pseudo+"';";
	      User user = null;
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user_test = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user_test.setPseudo(rs.getString("login"));
	    		  Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(rs.getString("birthday")); 
	    		  user_test.setAnniversaire(date1);
	    		  user=user_test;
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return user;  
	  }
	  
	  
	  public static ArrayList<User> getAllUsersByName(String name) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT user.name as name,login,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role "
	      		+ "AND (concat(user.name , ' ' , firstName) LIKE '%"+name+"%'\r\n"
	      		+ "OR  firstName LIKE '%"+name+"%' \r\n"
	      		+ "OR  user.name LIKE '%"+name+"%'"
	      		+ "OR login LIKE '%"+name+"%');";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user.setPseudo(rs.getString("login"));
	    		  listUser.add(user);
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
	                + "VALUES('"+id+"','"+user.getPseudo()+"','"+mdp+"','"+user.getName()+"','"+user.getFirstName()+"','"+strDate+"','1')";
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static boolean updateUser(User user,String old_mdp,String new_mdp) throws SQLException {
		  Date date = user.getAnniversaire();  
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");  
		  String strDate = dateFormat.format(date);  
		  String SQL = "UPDATE User"
		  		+ " SET name='"+user.getName()+"',"
		  				+ "firstName='"+user.getFirstName()+"',"
		  						+ "birthday='"+strDate+"'";
		  
	      if (old_mdp != "" && new_mdp !="") {
	    	  
	    	  if(UserDAO.checkAccount(user.getPseudo(),old_mdp)) {
	    		  SQL += ", password='"+new_mdp+"' ";
	    	  }else return false;
	    	  
	      }
	      
	      SQL += " WHERE login='"+user.getPseudo()+"'";
	      
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(SQL);
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
