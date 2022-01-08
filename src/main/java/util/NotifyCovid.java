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
import java.util.HashSet;

import util.SingletonConnection;
import metier.Lieu;
import metier.Notification;
import metier.User;

public final class NotifyCovid {
	
	  private static NotifyCovid instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new NotifyCovid();
	  }
	  
	  public final static NotifyCovid getInstance() { return instance; }
	  
	  private NotifyCovid() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        }
	  }

	  public static void notifyContactCases(String user_id) throws SQLException {
		  var activities = ActiviteDAO.getAllActiviteByUserParticipate(user_id);
		  HashSet<String> toNotify = new HashSet<>();
		  activities.forEach(act -> {
			  Date now = new Date();
			  long delta = now.getTime() - act.getEnd().getTime();
			  long difference_In_Days = delta / (1000 * 60 * 60 * 24);
			  
			  if (difference_In_Days <= 7) {
				  try {
					  ArrayList<String> id_users = ActiviteDAO.getAllUsersByActivite(act.getId());
					  
					  ArrayList<String> id_friends = UserDAO.getAllFriends(user_id);
					  
					  toNotify.addAll(id_friends);
					  
					  id_users.forEach(user -> toNotify.add(user));
				  } catch (SQLException e) {
					  e.printStackTrace();
				  }
			  }
		  });
		  
		  
		  toNotify.forEach(user -> {
			  if (user.equals(user_id)) {
		     NotificationDAO.insertNotification(user, (new Date()), "Vous avez déclaré être positif au Covid, prevenez vos proches et prenez les mesures nécessaires pour vous protégez vous et les autres.");
			  }else
			 NotificationDAO.insertNotification(user, (new Date()), "Vous avez récemment fréquenté un lieu commun avec au moins une personne positive à la Covid-19, merci de vous faire tester.");
		  });
	  }
	  
	}
