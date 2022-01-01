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
import metier.Notification;
import metier.User;

public final class NotificationDAO {
	
	  private static NotificationDAO instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new NotificationDAO();
	  }
	  
	  public final static NotificationDAO getInstance() { return instance; }
	  
	  private NotificationDAO() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        }
	  }

	  
	  public static ArrayList<Notification> getAllNotificationUser(String id) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM notification"
	      		+ " WHERE user="+id+";";
	      ArrayList<Notification> listNotification = new ArrayList<Notification>();
	      
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(rs.getString("receivedDate")); 
	    		  Notification notif = new Notification(rs.getString("id"),UserDAO.getUserById(id),date1,rs.getString("content"));
	    		  listNotification.add(notif);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listNotification;   
	  }
	  
	  public static boolean deleteNotif(String id) { 

		  String SQL = "DELETE FROM NOTIFICATION WHERE id="+id+";";
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static boolean insertNotification(String id_user,Date receivedDate, String content) { 
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
		  String strDate = dateFormat.format(receivedDate);  
		  String id = String.valueOf(NotificationDAO.maxIdNotif());
		  String SQL = "INSERT INTO Notification(id,user,receivedDate,content) "
	                + "VALUES('"+id+"','"+id_user+"','"+strDate+"','"+content+"')";
		  
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static int maxIdNotif() {
		  ResultSet rs = null;
		  int max_id=-1;
		  String requete_id = "SELECT MAX(CONVERT(id, SIGNED)) as id FROM notification LIMIT 1";
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
