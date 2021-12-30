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

public final class PaysDAO {
	
	  private static PaysDAO instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new PaysDAO();
	  }
	  
	  public final static PaysDAO getInstance() { return instance; }
	  
	  private PaysDAO() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        }
	  }

	  
	  public static ArrayList<String> getAllPays() throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT nom_fr_fr as nom from pays";
	      ArrayList<String> listPays = new ArrayList<String>();
	      
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  listPays.add(rs.getString("nom"));
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listPays;
	  }
	  
	  
	}
