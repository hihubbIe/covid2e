

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String LOGIN="grosconnard";
	private static String MDP="oui";
       
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
	     String mdp = request.getParameter("password");
	     
	     if (nom != null && mdp != null) {
		     if (nom.equals(LOGIN) && mdp.equals(MDP)) {
		         HttpSession session = request.getSession();
		         session.setAttribute("login", nom);
		         session.setAttribute("mdp", mdp);
		         response.sendRedirect("indexConnecte.jsp");
		     }else
		     {
		    	 response.sendRedirect("index.jsp?log=false");
		     }
	     }else {
	    	 response.sendRedirect("index.jsp?log=false");
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
