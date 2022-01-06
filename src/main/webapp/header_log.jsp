<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,metier.Notification,util.NotificationDAO,
util.PaysDAO,util.LieuDAO,metier.Lieu,metier.Activite,util.ActiviteDAO" %>


<html>
<head>
<meta charset="ISO-8859-1">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/navbar.css" />
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
  <nav class=" nav_header navbar navbar-expand-lg navbar-light bg-dark  fixed-top ">
  <a class="navbar-brand nav_bar_light" href="index.jsp">Covid</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
       <li class="nav-item active">
        <a class="nav-link nav_bar_light" href="listUsers.jsp">Liste des utilisateurs <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link nav_bar_light" href="myProfil.jsp">Mon profil <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link nav_bar_light" href="friendList.jsp">Mes amis <span class="sr-only">(current)</span></a>
      </li>
       <li class="nav-item active">
       <div class="btn-group" role="group">
       <a class="nav-link nav_bar_light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="#">
	      Activités
	    </a>
	        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
		        <a class="nav-link dropdown-item" href="listActivite.jsp">Activités <span class="sr-only">(current)</span></a>
		        <a class="nav-link dropdown-item" href="listActivite.jsp?mylist=1">Mes activités <span class="sr-only">(current)</span></a>
		        <a class="nav-link dropdown-item" href="listActivite.jsp?myparticipation=1">Mes participations <span class="sr-only">(current)</span></a>
		    	<a class="nav-link dropdown-item" href="carte.jsp?myparticipation=1">Carte des activités <span class="sr-only">(current)</span></a>
		    </div>
	    </div>
      </li>
       <li class="nav-item active">
        <a class="nav-link nav_bar_light" href="notification.jsp"><img style="width:1em;filter: invert(1);" alt="notification" src="https://www.pinclipart.com/picdir/big/185-1850576_png-file-white-bell-notification-icon-transparent-clipart.png">
        <% NotificationDAO.getInstance(); 
    	ArrayList<Notification> listNotif = new ArrayList<Notification>();
        listNotif = NotificationDAO.getAllNotificationUser(UserDAO.getIDbyPseudo(session.getAttribute("login").toString()));
        if (listNotif.size()>0)
        out.println("<span class='badge'>"+listNotif.size()+"</span>");
        %></a>
      </li>
      
    </ul>
    
     <ul class="navbar-nav mr-0">
  	  <li class="nav-item">
        <a class="nav-link nav_bar_light" href="Deconnecter">Se deconnecter</a>
      </li>
      
       <li class="nav-item">
        	<div class="nav-link nav_bar_light">Bienvenue <% out.println(session.getAttribute("login")); %> ! </div>
      </li>
    </ul>
  </div>
</nav>

</html>