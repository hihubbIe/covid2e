

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
 * Servlet implementation class AddActivite
 */
@WebServlet("/AddActivite")
public class AddActivite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddActivite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String nom = request.getParameter("nom").trim().replaceAll(" +", " ");
		 String id_lieu = request.getParameter("id_lieu").trim().replaceAll(" +", " ");
		 String date_debut = request.getParameter("debut").replaceAll("T", " ");
		 String date_fin = request.getParameter("fin").replaceAll("T", " ");
		
	    Date debut = null;
	    Date fin = null;
	    
	    
		try {
			debut = new SimpleDateFormat("yyyy-mm-dd HH:mm").parse(date_debut);
			fin = new SimpleDateFormat("yyyy-mm-dd HH:mm").parse(date_fin);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
		if (debut.equals(fin) || debut.after(fin) ) {
			response.sendRedirect("activite.jsp?date=1");
		}else {
			
			ActiviteDAO.getInstance();
			LieuDAO.getInstance();
			
			Activite act = null;
			try {
				act = new Activite (nom,LieuDAO.getLieuByID(id_lieu),debut,fin);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			ActiviteDAO.insertActivite(act);
			
			response.sendRedirect("activite.jsp?success=1");
		}
		
	}

	
}
