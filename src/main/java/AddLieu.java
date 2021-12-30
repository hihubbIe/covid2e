

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.util.Date;
import java.util.Scanner;

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
		String rue = request.getParameter("rue").trim().replaceAll(" +", " ");	
		String postal = request.getParameter("postal");	
		String ville = request.getParameter("ville");	
		String pays = request.getParameter("pays");	
		
		Lieu lieu = new Lieu(numero,rue,postal,ville,pays);
		
		lieu.setName(nom);
		
		LieuDAO.getInstance();

        URL url = new URL("https://api-adresse.data.gouv.fr/search/?q="+numero+"%20"+rue.replaceAll(" ", "%20")+"%20"+postal+"%20"+ville+"&type=housenumber&autocomplete=0");

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.connect();

        //Check if connect is made
        int responseCode = conn.getResponseCode();

        // 200 OK
        if (responseCode != 200) {
    		response.sendRedirect("lieu.jsp?echec=1");
        } else {

            StringBuilder informationString = new StringBuilder();
            Scanner scanner = new Scanner(url.openStream());

            while (scanner.hasNext()) {
                informationString.append(scanner.nextLine());
            }
            //Close the scanner
            scanner.close();
            	
            String score_string = informationString.toString();
            
            double score= Double.parseDouble(score_string.substring(score_string.indexOf("score")+8,score_string.indexOf("score")+15));
            
            if (score >= 0.9) {
        		LieuDAO.insertLieu(lieu);
        		response.sendRedirect("lieu.jsp?success=1");
            }else {
        		response.sendRedirect("lieu.jsp?echec=1");
            }
        }
  	
		
	}
	

}
