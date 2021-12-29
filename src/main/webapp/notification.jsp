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
						String content=listNotifs.get(i).getContent();
						String notif_string = "";
						notif_string = " <li class='list-group-item'>";
						notif_string += " <form action='DeleteNotification' method='post' class=''>";
						notif_string += listNotifs.get(i).getContent().substring(content.indexOf("|")+1)+"<input type='hidden' name='id' value='";
						notif_string += listNotifs.get(i).getId()+"'/> <button class='btn btn-danger btn-sm' style='float:right;' type='submit'>"
								+" <i class='material-icons'></i>Supprimer</button>";
						notif_string +="</form>";		
						if (content.substring(0,5).equals("[ADD]")){
							String id=content.substring(content.indexOf("-")+1,content.indexOf("|"));
							notif_string +="<form action='AddFriend' method='get'>";
							notif_string +="<input type='hidden' name='id_user_cible' value='"+id+"' />"+"<input type='hidden' name='id_notif' value='"+listNotifs.get(i).getId()+"' />"+"<button style='float:right;margin-top:1em;margin-right:-5.2em;' class='btn btn-success btn-sm' type='submit'> <i class='material-icons'></i>Accepter</button>";
						}
						notif_string+="</li>";
						
						out.println(notif_string);
					
					}
					
					out .println("</ul>");
				}
				
				


				
				
			%>
				
			</div>
		</div>
	</div>

</div>
</html>