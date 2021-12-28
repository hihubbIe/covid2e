<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	

<% if (session.getAttribute("login")==null || session.getAttribute("login")==""){ 

	response.sendRedirect("login.jsp");
	
}



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Liste d'amis</title>

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
	<h1>Liste des amis</h1>
	

	<div class="container css-container">
		<div class="main-body">
		
		<form action="RechercheFriend" method="post" class="">
		
		<div class="input-group" style="margin-bottom:1em;">
		  <div class="form-outline">
		    <input type="search" id="form1" class="form-control" placeholder="Nom, prenom, pseudo" name="filtre_user_1" />
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
				
				User me = UserDAO.getUserByPseudo(session.getAttribute("login").toString());
				int count_friend=0;
				for (int i=0;i<listUsers.size();i++){
					if (UserDAO.isFriend(me, listUsers.get(i))){
						count_friend++;
						out.println("<div class='col mb-3'>");
						out.println("<div class='card'>");
						out.println("<img src='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBolGxUVITEhMSk3Ljo6Fx8zOD84NygtOjcBCgoKDQ0NDw0NDisZFRkrKy03LS0rKy03LS0tKysrNzctLTc3Nys3Ny0tLS03LTctNy03NzctKy0tKy03NzctLf/AABEIAMIBAwMBIgACEQEDEQH/xAAXAAEBAQEAAAAAAAAAAAAAAAAAAQID/8QAFhABAQEAAAAAAAAAAAAAAAAAABEB/8QAFwEBAQEBAAAAAAAAAAAAAAAAAAEGBf/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AOkWCtK4aRYpASCqCQigIqgJCKoiEUFQUESCgJCLBFQWAMjSAiNAMkUBlI0AxBpBWVAGsUxVQFIKAoiCgAoCKKCCgIKIIKAgoCCgIjSAgqAgqAgqAiRpBWRpAaxTFVAUBFVABRAFBEUUEFAQUBBQEFBUFAZFEERpARGkBEUBEUVUBQVRVQFAQiqggoACiIoACgqCgiCgIKIqIoCCoCCgMigMigMioqoKA0piiIoACgAKCCggCoAQgAoCCgqAAgoCI0gIjSAgqAiKAiKCsqKDSpiqgKAAoIoIAKIigAKAgoCCgqCgIACCoCCoCCoCCoCIoKyoA3imKqIoIAoACggoCLmAIKAAAAAoigIACCgIigIioCCoCI0gMigreKKqAKggoIAoIoCgKCKAgAKAAIoCAAgoCIoCIqAgqAiNIKiKA3iiiAAAoIAoIoCgKCCgAAAAIKIIACCooIqIIKiiCoCIoKgAOgKIAAKAAKIAIoCggoAACCgIKAgAIKgCKgIKgIjSKIigqAA6BiiAAAoACoIoAAoIKAgoCCgIKgCKAgAIKgIKgqI0gIigIADeKCooCACgAAAoAAAAAAAACKAgqAIqAAAiKCoioCAAgKDagIACKAKAAoAgAAKAIoCAAACggICAoIAqagAigMgCgAP/2Q=='"+
						" alt='Cover' class='card-img-top' style='height:5em;'>");
						out.println("<div class='card-body text-center'>");
						out.println("<img src='https://bootdey.com/img/Content/avatar/avatar7.png' style='width: 100px; margin-top: -65px' alt='User' class='img-fluid img-thumbnail rounded-circle border-0 mb-3'>");
						
						out.println("<h5 class='card-title'>"+listUsers.get(i).getFirstName()+" "+listUsers.get(i).getName()+"</h5>");
						out.println("<p class='text-secondary mb-1'>"+listUsers.get(i).getPseudo()+"</p>");
						out.println("<p class='font-weight-bold font-size-sm'>"+listUsers.get(i).getRole()+"</p>");
						
						out.println("<div class='card-footer'>");
						out.println("<form method='post' action='DeleteFriend'><input type='hidden' name='pseudo' value='"+listUsers.get(i).getPseudo()+"' /><button class='btn btn-danger btn-sm' type='submit'> <i class='material-icons'></i>Retirer des amis </button></form>");
						out.println("<form method='get' action='profil.jsp'><input type='hidden' name='pseudo' value='"+listUsers.get(i).getPseudo()+"' /><button class='btn btn-info btn-sm ml-3' type='submit' >Profil</button></form>");
						out.println("</div></div></div></div>");
					}
				}
				
				if (count_friend==0){
					out.println("<h2>Vous n'avez pas d'amis ! :(</h2>");
				}
				
				
			%>
				
			</div>
		</div>
	</div>

</div>
</html>