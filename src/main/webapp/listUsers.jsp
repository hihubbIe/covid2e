<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	

<% if (session.getAttribute("login")==null){ 

	response.sendRedirect("login.jsp");
	
}



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bienvenue</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	
<link rel="stylesheet" href="css/accueil.css" />

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList" %>
<%@ include file="header_log.jsp" %>
<div class="main-div2">
	<h1>Liste des utilisateurs</h1>
	

	<div class="container css-container">
		<div class="main-body">
		
		<form action="RechercheUser" method="post" class="">
		
		<div class="input-group" style="margin-bottom:1em;">
		  <div class="form-outline">
		    <input type="search" id="form1" class="form-control" placeholder="Nom prenom" name="filtre_user_1" />
		  </div>
		  <button type="submit" class="btn btn-primary" style="width:10%;margin-left:1em;">
		    <i class="fas fa-search">Rechercher</i>
		  </button>
		    <button formaction="listUsers.jsp" type="submit" class="btn btn-warning" style="width:10%;margin-left:1em;">
		    <i class="fas fa-search">Clear</i>
		  </button>
		</div>
		
		</form>


			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
			<%  
			ArrayList<User> listUsers = new ArrayList<User>();
			UserDAO.getInstance();
			if(request.getParameter("filtre")==null) listUsers = UserDAO.getAllUsers();
			else listUsers = UserDAO.getAllUsersByName(request.getParameter("filtre"));
			for (int i=0;i<listUsers.size();i++){
				out.println("<div class='col mb-3'>");
				out.println("<div class='card'>");
				out.println("<img src='https://via.placeholder.com/340x120/FFB6C1/000000' alt='Cover' class='card-img-top'>");
				out.println("<div class='card-body text-center'>");
				out.println("<img src='https://bootdey.com/img/Content/avatar/avatar7.png' style='width: 100px; margin-top: -65px' alt='User' class='img-fluid img-thumbnail rounded-circle border-0 mb-3'>");
				
				out.println("<h5 class='card-title'>"+listUsers.get(i).getPrenom()+" "+listUsers.get(i).getName()+"</h5>");
				out.println("<p class='text-secondary mb-1'>Full Stack Developer</p>");
				out.println("<p class='font-weight-bold font-size-sm'>"+listUsers.get(i).getRole()+"</p>");
				
				out.println("<div class='card-footer'>");
				out.println("<button class='btn btn-light btn-sm bg-white has-icon btn-block' type='button'> <i class='material-icons'>add</i>Follow </button>");
				out.println("<button class='btn btn-light btn-sm bg-white has-icon ml-2' type='button'>Truc</button>");
				out.println("</div></div></div></div>");
			}
			%>
				
			</div>
		</div>
	</div>

</div>
</html>