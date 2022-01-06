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
import metier.Activite;
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
	      String requete = "SELECT user.name as name,photo,login,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role;";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user.setPseudo(rs.getString("login"));
	    		  user.setPhoto(rs.getString("photo"));
	    		  
	    		  listUser.add(user);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listUser;   
	  }
	  
	  public static ArrayList<User> getAllUsersByActivite(String id_activite) throws SQLException {
		  ResultSet rs = null;
		   String requete = "SELECT user.name as name,photo,login,firstName,role,role.name as role_name "
		      		+ "FROM user,role,participates WHERE role.id=user.role AND user.id=participates.user AND activity="+id_activite;
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user.setPseudo(rs.getString("login"));
	    		  user.setPhoto(rs.getString("photo"));
	    		  
	    		  listUser.add(user);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listUser;   
	  }
	  
	  public static User getUserByPseudo(String pseudo) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT user.name as name,birthday,login,photo,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role AND login='"+pseudo+"';";
	      User user = null;
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user_test = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user_test.setPseudo(rs.getString("login"));
	    		  Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(rs.getString("birthday")); 
	    		  user_test.setAnniversaire(date1);
	    		  user_test.setPhoto(rs.getString("photo"));
	    		  user=user_test;
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return user;  
	  }
	  
	  public static User getUserById(String id) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT user.id,user.name as name,birthday,login,photo,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role AND user.id='"+id+"';";
	      User user = null;
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user_test = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user_test.setPseudo(rs.getString("login"));
	    		  Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(rs.getString("birthday")); 
	    		  user_test.setAnniversaire(date1);
	    		  user_test.setPhoto(rs.getString("photo"));
	    		  user=user_test;
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return user;  
	  }
	  
	  
	  public static ArrayList<User> getAllUsersByName(String name) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT user.name as name,photo,login,firstName,role,role.name as role_name "
	      		+ "FROM user,role WHERE role.id=user.role "
	      		+ "AND (concat(user.name , ' ' , firstName) LIKE '%"+name+"%' "
	      		+ "OR  (concat(firstName , ' ' , user.name) LIKE '%"+name+"%') "
	      		+ "OR  firstName LIKE '%"+name+"%' "
	      		+ "OR  user.name LIKE '%"+name+"%' "
	      		+ "OR login LIKE '%"+name+"%');";
	      ArrayList<User> listUser = new ArrayList<User>();
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  User user = new User(rs.getString("name"),rs.getString("firstName"),rs.getString("role_name"));
	    		  user.setPseudo(rs.getString("login"));
	    		  user.setPhoto(rs.getString("photo"));
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
	                + "VALUES('"+id+"','"+user.getPseudo().replaceAll("[<>]","")+"','"+mdp+"','"+user.getName().replaceAll("[<>]","")+"','"+user.getFirstName().replaceAll("[<>]","")+"','"+strDate+"','1')";
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
		  		+ " SET name='"+user.getName().replaceAll("[<>]","")+"',"
		  				+ "firstName='"+user.getFirstName().replaceAll("[<>]","")+"',"
		  						+ "birthday='"+strDate+"',"
		  							+"photo='"+user.getPhoto()+"'";
		  
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
		  String requete_id = "SELECT MAX(CONVERT(id, SIGNED)) as id FROM user LIMIT 1";
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
	  

	  public static String getIDbyPseudo(String pseudo) {
		  ResultSet rs = null;
		  String id="-1";
		  String requete_id = "SELECT id from user WHERE login='"+pseudo+"';";
	      try {	  
	    	  rs = stmt.executeQuery(requete_id);
	    	  rs.next();
	    	  id = rs.getString("id");
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      
	      return id;  
	  }
	  
	  public static boolean isFriend(User user1,User user2) {
		  
		  ResultSet rs = null;
		  int count = 0;
		  String id1,id2="-1";
		  UserDAO.getInstance();
		  id1=UserDAO.getIDbyPseudo(user1.getPseudo());
		  id2=UserDAO.getIDbyPseudo(user2.getPseudo());
		  
	      String requete = "SELECT * from friend"
	      		+ " WHERE  ((friend1='"+id1+"' and friend2='"+id2+"') or (friend2='"+id1+"' and friend1='"+id2+"'))"
	      		;
	      
	      try {	  	  
	    	  rs = stmt.executeQuery(requete);
	    	  while(rs.next()) {
	    		  count++;
	    	  }
	      } catch (Exception e) {
	    	  e.printStackTrace();
	      }
	      if (count>=1) return true;
		  return false;
	  }
	  
	  public static boolean addFriend(User user1, User user2) { 
		  if (!UserDAO.isFriend(user1, user2)) {
			  String SQL = "INSERT INTO friend(friend1,friend2,friend.update,friend.status)"
		                + " VALUES('"+UserDAO.getIDbyPseudo(user1.getPseudo())+"','"+UserDAO.getIDbyPseudo(user2.getPseudo())+"',NOW(),'1')";
			  try {	  
		    	  stmt.executeUpdate(SQL);
		    	  return true;
				} catch (Exception e) {
					e.printStackTrace();
			  }
		  }
		  return false;
	  }
	  
	  public static boolean deleteFriend(User user1, User user2) { 
		  String id1=UserDAO.getIDbyPseudo(user1.getPseudo());
		  String id2=UserDAO.getIDbyPseudo(user2.getPseudo());
		  String SQL = "DELETE FROM friend"
		  		+ " WHERE ((friend1='"+id1+"' and friend2='"+id2+"') or (friend1='"+id2+"' and friend2='"+id1+"'))";
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static boolean deleteUser(String id) throws SQLException { 
		  
		  ActiviteDAO.getInstance();
		  ArrayList<Activite> listActivite = ActiviteDAO.getAllActiviteByUser(id);
		  
		  ArrayList<String> listIdActivite = new ArrayList<String>();
		  
		  for (int i = 0; i<listActivite.size(); i++) {
			  listIdActivite.add(listActivite.get(i).getId());
		  }

		  String SQL1 = "DELETE FROM user WHERE id="+id+";";
		  String SQL2 = "DELETE FROM participates WHERE user="+id+";";
		  String SQL3 = "DELETE FROM organises WHERE user="+id+";";
		  String SQL4 = "DELETE FROM notification WHERE user="+id+";";
		  try {	  
	    	
	    	  stmt.executeUpdate(SQL2);
	    	  stmt.executeUpdate(SQL3);
	    	  stmt.executeUpdate(SQL4);
	    	  
	    	  for (int i = 0; i<listIdActivite.size(); i++) {
				  stmt.execute("DELETE FROM activity WHERE id="+listIdActivite.get(i));
			  }
	    	  
	    	  stmt.executeUpdate(SQL1);
			  
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  
	  
		
	
}
