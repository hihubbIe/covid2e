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
      
      		
		<form class="mt-3 mb-3 pt-3" action="activite.jsp">
				
				<div class="d-flex">
						<button type="submit"
							class="btn btn-info">Ajouter une activité</button>
					</div>
				
				</form>
		
		<% 
		
		ArrayList<Activite> listActivite = new ArrayList<Activite>();
		ActiviteDAO.getInstance();
		
		listActivite = ActiviteDAO.getAllActivite();
		
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		DateFormat formatheure = new SimpleDateFormat("HH:mm");
		if (listActivite.size()!=0){
			for (int i = 0; i<listActivite.size(); i++){
				
				out.println("<div class='card mb-3'>");
				out.println("<h5 class='card-header'>"+formatter.format(listActivite.get(i).getStart())+" à "+ formatheure.format(listActivite.get(i).getStart()) +" </h5>");
				out.println("<div class='card-body'>");
				out.println("<h5 class='card-title'>"+listActivite.get(i).getName()+"</h5>");
				out.println("<p class='card-text'>"+listActivite.get(i).getAddress().toString()+"</p>");
				out.println("<a href='#' class='btn btn-primary'>Go somewhere</a>");
				out.println("</div></div>");
				
			}
			
		}else{
			out.println("<h2>Aucune activités ! </h2>");
		}
		
		
		
		%>
      
      </div>

    </main>
</div>
</html>