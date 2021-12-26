<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Accueil</title>


<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


<% if (session.getAttribute("login")==null){ %>
	<%@ include file="header_nolog.jsp" %>
<%}else{%>
	<%@ include file="header_log.jsp" %>
	<%}%>

<link rel="stylesheet" href="css/accueil.css" />
</head>


<div class="main-div">

    <main role="main" class="container">
      <div class="starter-template">
        <h1>Bienvenue sur CovidAction</h1>
        <br>
        <p class="lead">Grâce à ce site, vous pouvez protéger vos proches en communiquant sur votre situation afin <br> de savoir si ils sont cas contacts ! </p>
        <p class ="lead">Pour en savoir, plus veuillez vous connecter ou vous inscrire si ce n'est pas déjà fait !</p>
      </div>

    </main>
</div>
</html>