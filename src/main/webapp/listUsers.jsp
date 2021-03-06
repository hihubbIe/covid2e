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
		    <input type="search" id="form1" class="form-control" placeholder="Nom, prenom, pseudo" name="filtre_user_1" />
		  </div>
		  <button type="submit" class="btn btn-primary" style="width:10%;margin-left:1em;">
		    <i class="fas fa-search">Rechercher</i>
		  </button>
		    <button formaction="listUsers.jsp" type="submit" class="btn btn-warning" style="width:10%;margin-left:1em;">
		    <i class="fas fa-search">Clear</i>
		  </button>
		</div>
		
		<%			
		
		String testcompte = request.getParameter("add");
        if (testcompte != null && testcompte != ""){
        	out.println("<div style='color:green;'> Vous avez demand? "+testcompte+" en ami ! </div>");
        }
		
        %>
		
		</form>


			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
			<%
			
			ArrayList<User> listUsers = new ArrayList<User>();
				UserDAO.getInstance();
				if(request.getParameter("filtre")==null) listUsers = UserDAO.getAllUsers();
				else listUsers = UserDAO.getAllUsersByName(request.getParameter("filtre"));
				
				User me = UserDAO.getUserByPseudo(session.getAttribute("login").toString());
				
				int limite_show = 0;
				if (listUsers.size()<50) limite_show=listUsers.size();
				else limite_show=50;
				for (int i=0;i<limite_show;i++){
					if (!me.getPseudo().equals(listUsers.get(i).getPseudo())){
						out.println("<div class='col mb-3'>");
						out.println("<div class='card'>");
						out.println("<img src='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ8NDQ0NFREWFhURFRUYHSggGBolGxUVITEhMSk3Ljo6Fx8zOD84NygtOjcBCgoKDQ0NDw0NDisZFRkrKy03LS0rKy03LS0tKysrNzctLTc3Nys3Ny0tLS03LTctNy03NzctKy0tKy03NzctLf/AABEIAMIBAwMBIgACEQEDEQH/xAAXAAEBAQEAAAAAAAAAAAAAAAAAAQID/8QAFhABAQEAAAAAAAAAAAAAAAAAABEB/8QAFwEBAQEBAAAAAAAAAAAAAAAAAAEGBf/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AOkWCtK4aRYpASCqCQigIqgJCKoiEUFQUESCgJCLBFQWAMjSAiNAMkUBlI0AxBpBWVAGsUxVQFIKAoiCgAoCKKCCgIKIIKAgoCCgIjSAgqAgqAgqAiRpBWRpAaxTFVAUBFVABRAFBEUUEFAQUBBQEFBUFAZFEERpARGkBEUBEUVUBQVRVQFAQiqggoACiIoACgqCgiCgIKIqIoCCoCCgMigMigMioqoKA0piiIoACgAKCCggCoAQgAoCCgqAAgoCI0gIjSAgqAiKAiKCsqKDSpiqgKAAoIoIAKIigAKAgoCCgqCgIACCoCCoCCoCCoCIoKyoA3imKqIoIAoACggoCLmAIKAAAAAoigIACCgIigIioCCoCI0gMigreKKqAKggoIAoIoCgKCKAgAKAAIoCAAgoCIoCIqAgqAiNIKiKA3iiiAAAoIAoIoCgKCCgAAAAIKIIACCooIqIIKiiCoCIoKgAOgKIAAKAAKIAIoCggoAACCgIKAgAIKgCKgIKgIjSKIigqAA6BiiAAAoACoIoAAoIKAgoCCgIKgCKAgAIKgIKgqI0gIigIADeKCooCACgAAAoAAAAAAAACKAgqAIqAAAiKCoioCAAgKDagIACKAKAAoAgAAKAIoCAAACggICAoIAqagAigMgCgAP/2Q=='"+
						" alt='Cover' class='card-img-top' style='height:5em;'>");
						out.println("<div class='card-body text-center'>");
						
						String image_profil="https://bootdey.com/img/Content/avatar/avatar7.png";
						
						if (listUsers.get(i).getPhoto()!= null) image_profil = listUsers.get(i).getPhoto();
						
						out.println("<img src='"+image_profil+"' style='width: 100px; height:100px; margin-top: -65px' alt='User' class='img-fluid img-thumbnail rounded-circle border-0 mb-3'>");
						
						out.println("<h5 class='card-title'>"+listUsers.get(i).getFirstName()+" "+listUsers.get(i).getName()+"</h5>");
						out.println("<p class='text-secondary mb-1'>"+listUsers.get(i).getPseudo()+"</p>");
						out.println("<p class='font-weight-bold font-size-sm'>"+listUsers.get(i).getRole()+"</p>");
						
						out.println("<div class='card-footer'>");
						
						if (UserDAO.isFriend(me, listUsers.get(i))){
							out.println("<form method='post' action='DeleteFriend'><input type='hidden' name='pseudo' value='"+listUsers.get(i).getPseudo()+"' /><button class='btn btn-danger btn-sm' type='submit'> <i class='material-icons'></i>Retirer des amis </button></form>");
						}else out.println("<form method='post' action='AddFriend'><input type='hidden' name='pseudo' value='"+listUsers.get(i).getPseudo()+"' /><button class='btn btn-success btn-sm' type='submit'> <i class='material-icons'></i>Ajouter en ami </button></form>");
						
						out.println("<form method='get' action='profil.jsp'><input type='hidden' name='pseudo' value='"+listUsers.get(i).getPseudo()+"' /><button class='btn btn-info btn-sm ml-3' type='submit' >Profil</button></form>");
						
						if (session.getAttribute("role").equals("0")){ 
							out.println("<form onSubmit=\"return confirm('Etes vous s?r de vouloir le bannir ?');\" method='post' action='DeleteUser' class='ml-4'><input type='hidden' name='id' value='"+UserDAO.getIDbyPseudo(listUsers.get(i).getPseudo())+"' /><button class='btn btn-danger btn-sm' type='submit'> <i class='material-icons'></i>BAN</button></form>");
						}
						
						out.println("</div></div></div></div>");
					}
				}
			%>
				
			</div>
		</div>
	</div>

</div>
</html>