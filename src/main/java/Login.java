

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Hash;
import util.UserDAO;
/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String LOGIN="";
	private String MDP="";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String nom = request.getParameter("name");
	     String mdp = Hash.sha256(request.getParameter("password"));
	     
	     if (nom != null && mdp != null) {
		     try {
				UserDAO.getInstance();
				if (UserDAO.checkAccount(nom, mdp)) {
				     HttpSession session = request.getSession();
				     session.setAttribute("login", nom);
				     session.setAttribute("mdp", mdp);
				     session.setAttribute("role", UserDAO.checkRole(nom, mdp));
				     session.setAttribute("id", UserDAO.getUserByPseudo(nom));
				     response.sendRedirect("listUsers.jsp");
				 }else
				 {
					 response.sendRedirect("login.jsp?log=false");
				 }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	     }else {
	    	 response.sendRedirect("login.jsp?log=false");
	     }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
