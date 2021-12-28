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
	  
	  
	}
