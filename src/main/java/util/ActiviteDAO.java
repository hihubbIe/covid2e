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
	      String requete = "SELECT * FROM activity WHERE start >= NOW() ORDER BY start ASC;";
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
	  
	  public static ArrayList<Activite> getAllActiviteByUser(String id_user) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM activity,organises WHERE start >= NOW() AND id=activity AND user="
		  +id_user+" ORDER BY start ASC;";
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
	  
	  public static boolean updateActivite(Activite acti) throws SQLException {
		  Date date_debut = acti.getStart();
		  Date date_fin = acti.getEnd();
		  
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");  
		  String date_debut_str = dateFormat.format(date_debut);  
		  String date_fin_str = dateFormat.format(date_fin);  
		  
		  String SQL = "UPDATE activity SET name='"+acti.getName()+"',address='"+acti.getAddress().getId()+"',start='"
		  +date_debut_str+"',end='"
		  +date_fin_str+"' WHERE id='"+acti.getId()+"'";
		  
		  stmt.executeUpdate(SQL);
		  
		  return true;
	  }
	  
	  public static Activite getActiviteByID(String id_activite) throws SQLException {
		  ResultSet rs = null;
	      String requete = "SELECT * FROM activity WHERE id="+id_activite;
	      LieuDAO.getInstance();
	      
	      Activite acti = null;

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
		    		return act;
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return acti;
	  }
	  
	  public static String getActiviteIdUser(String id_activite) {
		  ResultSet rs = null;
		  String requete_id = "SELECT user FROM organises WHERE activity="+id_activite;
	      try {	  
	    	  rs = stmt.executeQuery(requete_id);
			
	    	  while (rs.next()) {
	    		  return rs.getString("user");
	    	  }
			
			
			} catch (Exception e) {
				e.printStackTrace();
		  }
	      return "-1";
	  }
	  
	  public static boolean insertActivite(Activite activite,String pseudo_user) { 
		  UserDAO.getInstance();
		  String id_user = UserDAO.getIDbyPseudo(pseudo_user);
		  
		  Date date_debut = activite.getStart();
		  Date date_fin = activite.getEnd();
		  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");  
		  String strDate_debut = dateFormat.format(date_debut); 
		  String strDate_fin = dateFormat.format(date_fin); 
		  String SQL = "INSERT INTO ACTIVITY(id,name,address,start,end) "
	                + "VALUES('"+ActiviteDAO.maxIdActivite()+"','"+activite.getName()+"','"+activite.getAddress().getId()+"','"
				  +strDate_debut+"','"+strDate_fin+"');";
		  
		  String SQL2 = "INSERT INTO Organises (user,activity) VALUES ('"+id_user+"','"+ActiviteDAO.maxIdActivite()+"');";
		  
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  stmt.executeUpdate(SQL2);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static boolean participateActivite(String id_activite,String id_user) { 
		  UserDAO.getInstance();
		  
		  String SQL = "INSERT INTO Participates (user,activity) VALUES ('"+id_user+"','"+id_activite+"');";
		  
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  NotificationDAO.getInstance();
	    	  NotificationDAO.insertNotification(ActiviteDAO.getActiviteIdUser(id_activite), new Date(), 
	    			  UserDAO.getUserById(id_user).getPseudo() + " participe à votre évènement : " 
	    		      + ActiviteDAO.getActiviteByID(id_activite).getName());
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  public static boolean noParticipateActivite(String id_activite,String id_user) { 
		  String SQL = "DELETE FROM Participates WHERE user="+id_user+" AND activity="+id_activite;
		  try {	  
	    	  stmt.executeUpdate(SQL);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  
	  
	 public static boolean isParticipating(String id_activite, String pseudo_user) {
		 	  UserDAO.getInstance();
		 	  String id_user = UserDAO.getIDbyPseudo(pseudo_user);
			  
		 	  ResultSet rs = null;
			  int count = 0;
			  String requete = "SELECT * FROM participates WHERE user ="+id_user+" AND activity = "+id_activite;
		
		      
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
	 
	 public static boolean isOrganising(String id_activite, String pseudo_user) {
	 	  UserDAO.getInstance();
	 	  String id_user = UserDAO.getIDbyPseudo(pseudo_user);
		  
	 	  ResultSet rs = null;
		  int count = 0;
		  String requete = "SELECT * FROM organises WHERE user ="+id_user+" AND activity = "+id_activite;
			
	      
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
	 

	  public static int maxIdActivite() {
		  ResultSet rs = null;
		  int max_id=-1;
		  String requete_id = "SELECT MAX(CONVERT(id, SIGNED)) as id FROM activity LIMIT 1";
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
		  String SQL1 = "DELETE FROM activity WHERE id="+id+";";
		  String SQL2 = "DELETE FROM participates WHERE activity="+id+";";
		  String SQL3 = "DELETE FROM organises WHERE activity="+id+";";
		  try {	  
	    	  stmt.executeUpdate(SQL1);
	    	  stmt.executeUpdate(SQL2);
	    	  stmt.executeUpdate(SQL3);
	    	  return true;
			} catch (Exception e) {
				e.printStackTrace();
		  }
		  return false;
	  }
	  
	  
	  
	}
