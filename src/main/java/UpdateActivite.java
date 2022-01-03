

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import metier.Activite;
import metier.User;
import util.ActiviteDAO;
import util.Hash;
import util.LieuDAO;
import util.UserDAO;

/**
 * Servlet implementation class UpdateProfil
 */
@WebServlet("/UpdateActivite")
public class UpdateActivite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateActivite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("updateActivite.jsp?id_activite="+request.getParameter("id_activite"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String nom = request.getParameter("nom");
	    String id_lieu = request.getParameter("id_lieu");
	    String id_activite = request.getParameter("id_activite");
	    String date_debut = request.getParameter("debut").replaceAll("T", " ");
		String date_fin = request.getParameter("fin").replaceAll("T", " ");
	    Date debut = null;
	    Date fin = null;
	    	    
	    HttpSession session = request.getSession();
	    
	    
		try {
			debut = new SimpleDateFormat("yyyy-mm-dd HH:mm").parse(date_debut);
			fin = new SimpleDateFormat("yyyy-mm-dd HH:mm").parse(date_fin);
			
			if (debut.equals(fin) || debut.after(fin) ) {
				response.sendRedirect("updateActivite.jsp?id_activite="+id_activite+"&date=1");
			}else {
				LieuDAO.getInstance();
				
				Activite acti = new Activite(nom,LieuDAO.getLieuByID(id_lieu),debut,fin);
				acti.setId(id_activite);
				
				ActiviteDAO.getInstance();
				ActiviteDAO.updateActivite(acti);
				
				response.sendRedirect("updateActivite.jsp?id_activite="+id_activite+"&success=1");
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("updateActivite.jsp?id_activite="+id_activite+"&echec=1");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("updateActivite.jsp?id_activite="+id_activite+"&echec=1");
		}  
	
	}
	
}
