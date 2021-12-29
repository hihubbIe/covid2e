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
<title>Profil</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/accueil.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


</head>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat" %>
<%@ include file="header_log.jsp" %>
<% User profil = UserDAO.getUserByPseudo(request.getParameter("pseudo")); 
DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
String date_string = formatter.format(profil.getAnniversaire());
%>
<div class="main-div2">
	<div class="container-sm css-container-profil">
		<div class="main-body">
			<h1>Profil de : <% out.println(profil.getPseudo()); %></h1>
			
			<%if (profil.getPhoto()!= null && !profil.getPhoto().equals("")) 
				out.println("<img src='"+profil.getPhoto()
				+"' style='width: 100px; height:100px; margin-top: -65px' alt='User' class='img-fluid img-thumbnail rounded-circle border-1 mb-3'>"); %>
			
			
                <form>
              
                <div class="form-outline mb-4">
                <label class="form-label">Pseudo</label>
                  <input type="text" class="form-control form-control-lg" name="pseudo" value="<%out.println(profil.getPseudo());%>" readonly/>
                </div>

                <div class="form-outline mb-4">
                <label class="form-label">Nom</label>
                  <input type="text" class="form-control form-control-lg" name="nom" value="<%out.println(profil.getName());%>" readonly/>
                </div>

                <div class="form-outline mb-4">
                 <label class="form-label">Prénom</label>
                  <input type="text" class="form-control form-control-lg" name="prenom" value="<%out.println(profil.getFirstName());%>" readonly/>
                </div>
                
                <div class="form-outline mb-4">
                <label class="form-label">Anniversaire</label>
                  <div class="input-append date md-form md-outline" id="dp3">
				    <input class="form-control form-control-lg" type="text" id="datepicker" placeholder="dd/mm/yyyy" name="anni" value="<%out.println(date_string);%>" readonly/> 
				</div>
      
                </div>
                
                <div class="d-flex justify-content-center">
                  <button type="submit" formaction="listUsers.jsp"  class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Retour</button>
                </div>

              </form>
		</div>
	</div>
</div>
</html>