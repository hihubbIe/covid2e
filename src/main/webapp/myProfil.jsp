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
<title>Profil</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/accueil.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


</head>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat" %>
<%@ include file="header_log.jsp" %>
<% 
String pseudo = session.getAttribute("login").toString();
User profil = UserDAO.getUserByPseudo(pseudo); 
DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
String date_string = formatter.format(profil.getAnniversaire());
%>
<div class="main-div2">
	<div class="container-sm css-container-profil">
		<div class="main-body">
			<h1>Profil de : <% out.println(profil.getPseudo()); %></h1>
			
			
                <form action="UpdateProfil" method="post" class="">
                
                     
                 <%
	    			String testmdp = request.getParameter("mdp");
	                if (testmdp != null && testmdp != ""){
	                	out.println("<div style='color:red;'>L'ancien mot de passe est faux ! </div>");
	                }
				%>
				     
                 <%
	    			String testvide = request.getParameter("erreur");
	                if (testvide != null && testvide != ""){
	                	out.println("<div style='color:red;'> Les champs ne doivent pas être vide ! </div>");
	                }
				%>
				
				 <%
	    			String testsucces = request.getParameter("succes");
	                if (testsucces != null && testsucces != ""){
	                	out.println("<div style='color:green;'> Votre profil a été modifié ! </div>");
	                }
				%>
              
              
                <div class="form-outline mb-4">
                <label class="form-label">Pseudo</label>
                  <input type="text" class="form-control form-control-lg" name="pseudo" value="<%out.println(profil.getPseudo());%>" readonly/>
                </div>

                <div class="form-outline mb-4">
                <label class="form-label">Nom</label>
                  <input type="text" class="form-control form-control-lg" name="nom" value="<%out.println(profil.getName());%>"/>
                </div>

                <div class="form-outline mb-4">
                 <label class="form-label">Prénom</label>
                  <input type="text" class="form-control form-control-lg" name="prenom" value="<%out.println(profil.getFirstName());%>"/>
                </div>
                
                 <div class="form-outline mb-4">
                <label class="form-label">Anniversaire</label>
                  <div class="input-append date md-form md-outline" id="dp3">
				    <input class="form-control form-control-lg" type="text" id="datepicker" placeholder="dd/mm/yyyy" name="anni" value="<%out.println(date_string);%>"/> 
				       <span class="add-on"><i class="icon-calendar" id="cal2"></i></span>
				</div>
				
				 <div class="form-outline mb-4 mt-4">
                <label class="form-label">Ancien mot de passe</label>
                  <input type="password" class="form-control form-control-lg" name="old_mdp"/>
                </div>
                
                 <div class="form-outline mb-4">
                <label class="form-label">Nouveau mot de passe</label>
                  <input type="password" class="form-control form-control-lg" name="new_mdp"/>
                </div>
                
      
                </div>
                
                <div class="d-flex justify-content-center">
                  <button type="submit" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Modifier</button>
                </div>
                <br>
                <div class="d-flex justify-content-center">
                  <button type="submit" formaction="listUsers.jsp"  class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Retour</button>
                </div>
                

              </form>
		</div>
	</div>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" integrity="sha512-rxThY3LYIfYsVCWPCW9dB0k+e3RZB39f23ylUYTEuZMDrN/vRqLdaCBo/FbvVT6uC2r0ObfPzotsfKF9Qc5W5g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript">

jQuery.noConflict();
    $('#dp3').datepicker({
        weekStart: 1,
        format: 'dd/mm/yyyy',
        autoclose: true,
        todayHighlight: true,
        language: 'fr',
    });
</script>

</html>