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
import metier.Lieu;
import metier.Notification;
import metier.User;

public final class ActiviteDAO {
	
	  private static ActiviteDAO instance = null;
	  private static Connection con = null;
	  private static Statement stmt = null;
	  
	  static {
	    instance = new ActiviteDAO();
	  }
	  
	  public final static ActiviteDAO getInstance() { return instance; }
	  
	  private ActiviteDAO() {
		  try {
	           con = SingletonConnection.getConnection();
	           stmt = con.createStatement();
	        } catch (SQLException e) {
	        	System.out.println(e);
	        }
	  }

	  
	  public static ArrayList<Activite> getAllActivite() throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM activity WHERE start >= NOW()";
	      ArrayList<Activite> listActivite = new ArrayList<Activite>();
	      LieuDAO.getInstance();
	      
	      try {	  
	    	  rs = stmt.executeQuery(requete);
			
	    	  while (rs.next()) {
	    		String name = rs.getString("name");
	    		String id = rs.getString("id");
	    		String id_lieu = rs.getString("address");
	    		String debut = rs.getString("start");
	    		String fin = rs.getString("end");
	    		
	    		Date debut_date = new SimpleDateFormat("yyyy-mm-dd hh:mm").parse(debut);
	    		Date fin_date = new SimpleDateFormat("yyyy-mm-dd hh:mm").parse(fin);
	    		Lieu lieu = LieuDAO.getLieuByID(id_lieu);
	    		lieu.setId(id_lieu);
	    		
	    		Activite act = new Activite (name,lieu,debut_date,fin_date);
	    		act.setId(id);
	    		
	    		listActivite.add(act);
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return listActivite;
	  }
	  
	  public static boolean insertActivite(Activite activite) { 
		  Date date_debut = activite.getStart();
		  Date date_fin = activite.getEnd();
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");  
		  String strDate_debut = dateFormat.format(date_debut); 
		  String strDate_fin = dateFormat.format(date_fin); 
		  String SQL = "INSERT INTO ACTIVITY(id,name,address,start,end) "
	                + "VALUES('"+ActiviteDAO.maxIdActivite()+"','"+activite.getName()+"','"+activite.getAddress().getId()+"','"
				  +strDate_debut+"','"+strDate_fin+"')";
		  
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
 
	  
	  public static int maxIdActivite() {
		  ResultSet rs = null;
		  int max_id=-1;
		  String requete_id = "SELECT MAX(id) as id FROM activity LIMIT 1";
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
	  
	  
	  public static boolean deleteActivite(String id) { 
		  String SQL = "DELETE FROM activity WHERE id="+id+";"
				  +"; DELETE FROM participates WHERE activity="+id+";"
				  +"; DELETE FROM organises WHERE activity="+id+";";
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  
	  
	  
	  
	}
