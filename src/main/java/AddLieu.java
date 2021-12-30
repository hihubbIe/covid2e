

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import metier.Lieu;
import metier.User;
import util.LieuDAO;
import util.NotificationDAO;
import util.UserDAO;

/**
 * Servlet implementation class Lieu
 */
@WebServlet("/AddLieu")
public class AddLieu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddLieu() {
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
		String nom = request.getParameter("nom");		
		int numero = Integer.parseInt(request.getParameter("numero"));	
		String rue = request.getParameter("rue");	
		String postal = request.getParameter("postal");	
		String ville = request.getParameter("ville");	
		String pays = request.getParameter("pays");	
		
		Lieu lieu = new Lieu(numero,rue,postal,ville,pays);
		
		lieu.setName(nom);
		
		LieuDAO.getInstance();
		
		LieuDAO.insertLieu(lieu);
		
		response.sendRedirect("lieu.jsp?success=1");
		
	}
	

}
