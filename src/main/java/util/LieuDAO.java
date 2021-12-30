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
import metier.Lieu;
import metier.Notification;
import metier.User;

public final class LieuDAO {
	
	  private static LieuDAO instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new LieuDAO();
	  }
	  
	  public final static LieuDAO getInstance() { return instance; }
	  
	  private LieuDAO() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        }
	  }

	  
	  public static ArrayList<Lieu> getAllLieu() throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM address";
	      ArrayList<Lieu> listLieu = new ArrayList<Lieu>();
	      
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		  Lieu lieu = new Lieu(rs.getInt("number"), rs.getString("street"), 
	    				  rs.getString("zipcode"), rs.getString("city"), rs.getString("country"));
	    		  lieu.setCoord(rs.getString("coordinates"));
	    		  lieu.setName(rs.getString("name"));
	    		  listLieu.add(lieu);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listLieu;
	  }
	  
	  public static boolean insertLieu(Lieu lieu) { 
		  String SQL = "INSERT INTO ADDRESS(id,number,street,zipcode,city,country) "
	                + "VALUES('"+LieuDAO.maxIdLieu()+"','"+lieu.getNum()+"','"+lieu.getStreet()+"','"
				  +lieu.getZipcode()+"','"+lieu.getCity()+"','"+lieu.getCountry()+"')";
		  
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  
	  public static int maxIdLieu() {
		  ResultSet rs = null;
		  int max_id=-1;
		  String requete_id = "SELECT MAX(id) as id FROM address LIMIT 1";
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
