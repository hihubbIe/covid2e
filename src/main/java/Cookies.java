
import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Cookies")
public class Cookies extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Cookies() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // send HTML page to client
     
        out.println("<html>");
        out.println("<head><title>Cookies</title></head>");
        out.println("<body></br></br>");
   
        
        String name = request.getParameter("name");
        String value = request.getParameter("value");
        
        if (name != "" && value != "" && name!= null && value != null) {
        	Cookie c = new Cookie (name,value);  	
            response.addCookie(c);
            response.sendRedirect("cookies.jsp");
        }
  
      
         
        
        
        out.println("</body></html>");
        
        // String[] truc = requet.getParameterValues("truc") --> tableau de variable ( si on post multiple choix en checkbox par exemple)
        
        
        
        


		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
