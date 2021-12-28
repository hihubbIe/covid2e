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
<title>Notifications</title>

<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	
<link rel="stylesheet" href="css/accueil.css" />

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

</head>

<%@ include file="header_log.jsp" %>
<div class="main-div2">
	<h1>Mes notifications</h1>
	

	<div class="container css-container">
		<div class="main-body">
		
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 gutters-sm">
			<%
				ArrayList<Notification> listNotifs = new ArrayList<Notification>();
				UserDAO.getInstance();
				NotificationDAO.getInstance();
				
				listNotifs = NotificationDAO.getAllNotificationUser(UserDAO.getIDbyPseudo(session.getAttribute("login").toString()));
				
				int count_notif=listNotifs.size();
				
				if (count_notif==0){
					out.println("<h2>Vous n'avez pas de notifications !</h2>");
				}else{
					out.println("<ul style='min-width:500px;' class='list-group'>");
					for (int i = 0; i<listNotifs.size();i++){
						out.println("<a href='#' class='list-group-item list-group-item-action'>"+listNotifs.get(i).getContent()+"</a>");
					}
					
					out .println("</ul>");
				}
				
				


				
				
			%>
				
			</div>
		</div>
	</div>

</div>
</html>