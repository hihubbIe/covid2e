

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
import util.NotificationDAO;
import util.UserDAO;

/**
 * Servlet implementation class AddFriend
 */
@WebServlet("/AddFriend")
public class AddFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFriend() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id_user_cible");
		String id_notif = request.getParameter("id_notif");
		UserDAO.getInstance();
		NotificationDAO.getInstance();
		HttpSession session = request.getSession();

		try {
			User user1 = UserDAO.getUserByPseudo(session.getAttribute("login").toString());
			User user2 = UserDAO.getUserById(id);
			UserDAO.addFriend(user1, user2);
			NotificationDAO.insertNotification(UserDAO.getIDbyPseudo(user2.getPseudo()), new Date(),user1.getPseudo()+" vous a ajouté en ami");
			NotificationDAO.deleteNotif(id_notif);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("listUsers.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pseudo = request.getParameter("pseudo");		 
		UserDAO.getInstance();
		NotificationDAO.getInstance();
		HttpSession session = request.getSession();

		try {
			User user1 = UserDAO.getUserByPseudo(session.getAttribute("login").toString());
			User user2 = UserDAO.getUserByPseudo(pseudo);
			NotificationDAO.insertNotification(UserDAO.getIDbyPseudo(user2.getPseudo()), new Date(), "[ADD]-"+UserDAO.getIDbyPseudo(user1.getPseudo())+" | "+user1.getPseudo()+" veut vous ajouter en ami");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("listUsers.jsp?add="+pseudo);
		
	}

}
