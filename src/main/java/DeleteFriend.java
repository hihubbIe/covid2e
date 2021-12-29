

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
 * Servlet implementation class DeleteFriend
 */
@WebServlet("/DeleteFriend")
public class DeleteFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFriend() {
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
		
		String pseudo = request.getParameter("pseudo");		 
		UserDAO.getInstance();
		NotificationDAO.getInstance();
		
		
		
		HttpSession session = request.getSession();

		try {
			User user1 = UserDAO.getUserByPseudo(session.getAttribute("login").toString());
			User user2 = UserDAO.getUserByPseudo(pseudo);
			UserDAO.deleteFriend(user1, user2);
			NotificationDAO.insertNotification(UserDAO.getIDbyPseudo(user2.getPseudo()), new Date(), user1.getPseudo()+" vous a retiré de sa liste d amis.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		response.sendRedirect("friendList.jsp");
		
	}

}
