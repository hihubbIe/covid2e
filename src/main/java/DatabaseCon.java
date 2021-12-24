
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import util.Hash;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DatabaseCon
 */
@WebServlet("/DatabaseCon")
public class DatabaseCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DatabaseCon() {
        super();
        // TODO Auto-generated constructor stub
        // Connexion
      
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
    	out.println(Hash.sha256("123"));
       
        ResultSet rs = null;
        String requete = "SELECT * FROM user";

        try {
           Class.forName("com.mysql.jdbc.Driver");  
           Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/covid","root","");
           Statement stmt = con.createStatement();
           rs = stmt.executeQuery(requete);
           while (rs.next()) {
        	   out.println(rs.getString("name"));
        	   out.println(rs.getString("firstName"));
           }
        } catch (SQLException e) {
        	out.println(e);
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			out.println(e);
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
