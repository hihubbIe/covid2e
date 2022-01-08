

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

import metier.User;
import util.Hash;
import util.UserDAO;
/**
 * Servlet implementation class Inscription
 */
@WebServlet("/Inscription")
public class Inscription extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Inscription() {
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
		 String prenom = request.getParameter("prenom").trim().replaceAll(" +", " ");
		 String pseudo = request.getParameter("pseudo").trim().replaceAll(" +", " ").toLowerCase();
		 String date = request.getParameter("anni");
		 
		
		 
		 String mdp = Hash.sha256(request.getParameter("mdp"));
		 
	    Date date1 = null;
	    
		try {
			date1 = new SimpleDateFormat("dd/mm/yyyy").parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		
		Date now = new Date();
		

		long difference_day = now.getYear() - date1.getYear();
				 
		UserDAO.getInstance();
		int max_id = UserDAO.maxIdUser();
		User user_insert = new User(nom,prenom,"1");
		user_insert.setPseudo(pseudo);
		user_insert.setAnniversaire(date1);
		 
		 if (nom != "" && prenom != "" && pseudo != "" && date != null && mdp != null) {
			 try {
				if (UserDAO.checkPseudo(pseudo)) { // Si le pseudo existe déjà alors : 
					 response.sendRedirect("inscription.jsp?existe=1");
				 }
			    else if(difference_day < 18){
			    	 response.sendRedirect("inscription.jsp?age=1");
				}
				 else{
					 UserDAO.insertUser(max_id, user_insert, mdp);
					 response.sendRedirect("login.jsp?compte=1");
				 }
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}				 
		 } else response.sendRedirect("inscription.jsp?vide=1");
		 
		
	}

	
}
