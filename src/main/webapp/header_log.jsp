<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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