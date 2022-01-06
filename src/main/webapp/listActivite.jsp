<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
	response.sendRedirect("index.jsp");
}
%>

<html>


<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/accueil.css" />
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<meta charset="ISO-8859-1">
<title>Activités</title>
</head>

<%@include file="header_log.jsp"%>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat" %>

<div class="main-div">

    <main role="main" class="container mb-3">
      <div class="starter-template">
      
      <h1>Liste des activités</h1>
      
      		
		<form class="mt-3 mb-3 pt-3" action="activite.jsp">
				
				<div class="d-flex">
						<button type="submit"
							class="btn btn-info">Ajouter une activité</button>
					</div>
				
				</form>
		
		<% 
		
		Boolean test_participation = false;
		
		int count_participation = 1;
		
		ArrayList<Activite> listActivite = new ArrayList<Activite>();
		ActiviteDAO.getInstance();
		UserDAO.getInstance();
		
		String my_pseudo = session.getAttribute("login").toString();
		
		// Pour savoir si on veut notre liste des activités ou la liste en général
		
		String testlist = request.getParameter("mylist");
        if (testlist == null || testlist == ""){
        	listActivite = ActiviteDAO.getAllActivite();
        }else listActivite = ActiviteDAO.getAllActiviteByUser(UserDAO.getIDbyPseudo(my_pseudo));
        
        String test_part = request.getParameter("myparticipation");
        if (test_part != null && test_part != ""){
        	test_participation=true;
        	count_participation=0;
        }
		
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		DateFormat formatheure = new SimpleDateFormat("HH:mm");
		

		
		if (listActivite.size()!=0){
			for (int i = 0; i<listActivite.size(); i++){
				
				Activite acti = listActivite.get(i);
				User organisateur = UserDAO.getUserById(ActiviteDAO.getActiviteIdUser(acti.getId()));
				String my_id = UserDAO.getIDbyPseudo(session.getAttribute("login").toString());
				
				// Si le filtre de participation est activé
				if (!test_participation || ActiviteDAO.isParticipating(acti.getId(),session.getAttribute("login").toString())){
					count_participation++;
					out.println("<div class='card mb-3'>");
					out.println("<h5 class='card-header'>"+formatter.format(acti.getStart())+" à "+ formatheure.format(acti.getStart()) +" </h5>");
					out.println("<div class='card-body'>");
					out.println("<h5 class='card-title'>"+acti.getName()+"</h5>");
					out.println("<p class='card-text'>"+acti.getAddress().toString()+"</p>");
					out.println("<p class='card-text'> par "+organisateur.getPseudo()+"</p>");
					out.println("<div class='row'>");
					
					out.println("<form class='ml-3' action='detailsActivite.jsp' method='get'>");
					out.println(" <input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
					+"<button class='btn btn-info btn-sm' type='submit'> <i class='material-icons'></i>Détails</button>");
					out.println("</form>");
					
					if (!ActiviteDAO.isParticipating((acti.getId()), my_pseudo)){ // Ne participe pas
						
						if (!ActiviteDAO.isOrganising(acti.getId(), my_pseudo)){
							out.println("<form class='ml-3' action='Participe' method='post'>");
							out.println("<input type='hidden' name='id_user' value='"+my_id+"' />"
						    +"<input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
							+"<button class='btn btn-success btn-sm' type='submit'> <i class='material-icons'></i>Participer</button>");
							out.println("</form>");
						} 
						else if (ActiviteDAO.isOrganising(acti.getId(), my_pseudo)){ // Suis-je l'orgnaisateur ?
							//Modifier
							out.println("<form class='ml-3' action='UpdateActivite' method='get'>");
							out.println(" <input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
							+"<button class='btn btn-warning btn-sm' type='submit'> <i class='material-icons'></i>Modifier</button>");
							out.println("</form>");
							//Supprimer
							out.println("<form class='ml-3' action='DeleteActivite' method='post'>");
							out.println(" <input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
							+"<button class='btn btn-danger btn-sm' type='submit'> <i class='material-icons'></i>Supprimer</button>");
							out.println("</form>");
						}
						if (session.getAttribute("role").equals("0")){ // Suis-je un admin ? 
							out.println("<form class='ml-3' action='DeleteActivite' method='post'>");
							out.println(" <input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
							+"<button class='btn btn-warning btn-sm' type='submit'> <i class='material-icons'></i>Supprimer (Admin)</button>");
							out.println("</form>");
						}
						
						
					}else{ // Participe
						out.println("<form class='ml-3' action='NeParticipePlus' method='post'>");
						out.println("<input type='hidden' name='id_user' value='"+my_id+"' />"
					    +"<input type='hidden' name='id_activite' value='"+acti.getId()+"' />"
						+"<button class='btn btn-danger btn-sm' type='submit'> <i class='material-icons'></i>Ne plus participer</button>");
						out.println("</form>");
					}
					
					out.println("</div></div></div>");
					
					}
			}
			
		}else{
			out.println("<h2>Aucune activités ! </h2>");
			count_participation=-1;
		}
		
		if (count_participation == 0){
			out.println("<h2>Aucune activités ! </h2>");
		}
		
		%>
      
      </div>

    </main>
</div>
</html>