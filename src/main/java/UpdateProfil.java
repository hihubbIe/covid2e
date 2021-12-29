

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

import metier.User;
import util.Hash;
import util.UserDAO;

/**
 * Servlet implementation class UpdateProfil
 */
@WebServlet("/UpdateProfil")
public class UpdateProfil extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfil() {
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
	    String nom = request.getParameter("nom");
	    String prenom = request.getParameter("prenom");
	    String date = request.getParameter("anni");
	    String pseudo = request.getParameter("pseudo");
	    Date date1 = null;
	    String photo = request.getParameter("photo");
	    photo=photo.replaceAll("\\<.*?\\>","");
	    
	   
	    
	    HttpSession session = request.getSession();
	    
		try {
			date1 = new SimpleDateFormat("dd/mm/yyyy").parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		 
		UserDAO.getInstance();
		User user_insert = new User(nom,prenom,session.getAttribute("role").toString());
		user_insert.setAnniversaire(date1);
		user_insert.setPseudo(pseudo);
	
		String old_mdp=request.getParameter("old_mdp");
		String new_mdp=request.getParameter("new_mdp");
		
		if (photo != "") user_insert.setPhoto(photo);
		
		if (old_mdp !="" && new_mdp !="") {
			old_mdp = Hash.sha256(old_mdp);
			new_mdp = Hash.sha256(new_mdp);
		}else {
			old_mdp ="";
			new_mdp ="";
		}
		
		if (nom != "" && prenom != "" && date != "") {
			try {
				if (old_mdp != "" && !UserDAO.updateUser(user_insert,old_mdp,new_mdp)) {
					response.sendRedirect("myProfil.jsp?mdp=1");
				}else {
					UserDAO.updateUser(user_insert,old_mdp,new_mdp);
					response.sendRedirect("myProfil.jsp?succes=1");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			response.sendRedirect("myProfil.jsp?erreur=1");
		}
		 
		
	}
}
