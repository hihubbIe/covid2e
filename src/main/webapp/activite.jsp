<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	
<% if (session.getAttribute("login") == null || session.getAttribute("login") == ""){ 
	response.sendRedirect("index.jsp");
}
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Activite</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	
<link rel="stylesheet" href="css/accueil.css" />

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<%@ include file="header_log.jsp" %>
<%@ page import="java.text.DateFormat,java.text.SimpleDateFormat" %>
<div class="main-div2">
	<h1>Activités</h1>
	

	<div class="container css-container">
		<div class="main-body">
		
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
				<div class="form-group">
					<label for="exampleFormControlSelect1">Lieu</label>
						<select class="form-control" id="rien" name="lieu">
			<%
				ArrayList<Lieu> listLieux = new ArrayList<Lieu>();
				LieuDAO.getInstance();
				listLieux = LieuDAO.getAllLieu();
				
				int count=listLieux.size();
	
				for (int i = 0; i<listLieux.size();i++){
					
					out.println("<option>");
	    			out.println(listLieux.get(i).getNum() + " " + listLieux.get(i).getStreet() + " " + listLieux.get(i).getZipcode()
	    					+ " " + listLieux.get(i).getCity());
	    			out.println("</option>");
					
				}
				
			%>
			</select>
			</div>
			
			<form action="lieu.jsp" method="post" class="">
                
			  <div class="d-flex justify-content-center">
                  <button type="submit" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Ajouter un lieu</button>
                </div>
            
            </form>
				
			</div>
		</div>
	</div>

</div>
</html>