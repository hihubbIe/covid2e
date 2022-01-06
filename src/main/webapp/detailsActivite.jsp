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
<title>Activité</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/accueil.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


</head>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat" %>
<%@ include file="header_log.jsp" %>
<% Activite acti = ActiviteDAO.getActiviteByID(request.getParameter("id_activite"));
User profil = UserDAO.getUserById(ActiviteDAO.getActiviteIdUser(request.getParameter("id_activite")));

SimpleDateFormat formatter = new SimpleDateFormat("EEEE dd MMMM yyyy à hh:mm");  

String DateDebut = formatter.format(acti.getStart());  
String DateFin = formatter.format(acti.getEnd());  

String my_id = UserDAO.getIDbyPseudo(session.getAttribute("login").toString());
%>
<div class="main-div2">
	<div class="container-sm css-container-profil">
		<div class="main-body">
			<h1>Activité : <% out.println(acti.getName()); %></h1>
			
                <form>
              
                <div class="form-outline mb-4">
                <label class="form-label">Adresse</label>
                  <input type="text" class="form-control form-control-lg" value="<%out.println(acti.getAddress().toString());%>" readonly/>
                </div>

                <div class="form-outline mb-4">
                <label class="form-label">Date de début</label>
                  <input type="text" class="form-control form-control-lg" value="<%out.println(DateDebut);%>" readonly/>
                </div>

                <div class="form-outline mb-4">
                 <label class="form-label">Date de fin</label>
                  <input type="text" class="form-control form-control-lg" value="<%out.println(DateFin);%>" readonly/>
                </div>
                
                <div class="form-outline mb-4">
	       	
                 <label class="form-label">Organisateur : </label>
                 	
                 	<%if (profil.getPhoto()!= null && !profil.getPhoto().equals("")) 
					out.println("<img src='"+profil.getPhoto()
					+"' style='width: 100px; height:100px;' alt='User' class='img-fluid img-thumbnail rounded-circle border-1 mb-3 ml-4 mr-4'>"); %>
				
					<%out.println("<a href='profil.jsp?pseudo="+profil.getPseudo()+"'>"+profil.getFirstName() + " " + profil.getName()+"</a>");%>
					
                </div>
                
                
                
                <div class="form-outline mb-4">
                 	Participants : 
                 	<br>
                 	<% UserDAO.getInstance();
                 	
                 	ArrayList<User> participants = UserDAO.getAllUsersByActivite(acti.getId());
                 	
                 	for (int i = 0; i<participants.size(); i++){
                 		User parti = participants.get(i);
                 		
                 		out.println("<br>");
                 		
                 		if (parti.getPhoto()!= null && !parti.getPhoto().equals("")) 
        					out.println("<img src='"+parti.getPhoto()
        					+"' style='width: 100px; height:100px;' alt='User' class='img-fluid img-thumbnail rounded-circle border-1 mb-3 ml-4 mr-4'>");
                 		
                 		out.println("<a href='profil.jsp?pseudo="+parti.getPseudo()+"'>"+parti.getFirstName() + " " + parti.getName()+"</a>");
                 		
        				
                 	}
                 	
                 	%>
                </div>

        		</form>
                </div>
                
                <%
                // Si t'es pas l'organisateur
                	if(!ActiviteDAO.isOrganising(acti.getId(),session.getAttribute("login").toString())){
                		// Si tu participes pas encore
                		if(!ActiviteDAO.isParticipating(acti.getId(), session.getAttribute("login").toString())){
                			out.println("<form class='d-flex justify-content-center' action='Participe' method='post'>");
							out.println("<input type='hidden' name='id_user' value='"+my_id+"' />"
						    +"<input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
							+"<button class='btn btn-success btn-block btn-lg gradient-custom-4 text-body' type='submit'> <i class='material-icons'></i>Participer</button>");
							out.println("</form>");
                		}else{// Sinon si tu participes 
                			out.println("<form class='d-flex justify-content-center' action='NeParticipePlus' method='post'>");
    						out.println("<input type='hidden' name='id_user' value='"+my_id+"' />"
    					    +"<input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
    						+"<button class='btn btn-warning btn-block btn-lg gradient-custom-4 text-body' type='submit'> <i class='material-icons'></i>Ne plus participer</button>");
    						out.println("</form>");
                		}
                		
                	}else{ // Si t'es l'organisteur
                		
                	}
                %>

                 <form>
                 <input type='hidden' name='id' value="<% out.print(acti.getId());%>">
                <div class="d-flex justify-content-center">
                  <button type="submit" formaction="carte.jsp"  class="btn btn-info btn-block btn-lg gradient-custom-4 text-body">Lieu sur la carte</button>
                </div>
                 </form>
                 
                <form>
                 <div class="d-flex justify-content-center">
                  <button type="submit" formaction="listActivite.jsp"  class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Retour</button>
                </div>
                </form>
		</div>
	</div>
</div>
</html>