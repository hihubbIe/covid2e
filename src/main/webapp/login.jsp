<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<% if (session.getAttribute("login")!=null){ 
	response.sendRedirect("index.jsp");
}
%>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/login.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<meta charset="ISO-8859-1">
<title>Login</title>
</head>

<%@include file="header_nolog.jsp" %>
<body>
<div class="sidenav">
         <div class="login-main-text">
            <h2>Application COVID</h2>
            <p>par ALGLAVE Ivan & DAO Denis</p>
         </div>
         <div>
         <img class="covidicon" src="image/covidicon.png">
         </div>
      </div>
      <div class="main">
         <div class="col-md-8 col-sm-12 login-wrap">
            <div class="login-form">
               <form action="Login" method="get" class="">
                   <%
	    			String testcompte = request.getParameter("compte");
	                if (testcompte != null && testcompte != ""){
	                	out.println("<div style='color:green;'> Compte crée ! </div>");
	                }
					%>	
                  <div class="form-group">
                     <label>Nom d'utilisateur</label>
                     <input type="text" class="form-control" placeholder="Pseudo" name="name">
                  </div>
                  <div class="form-group">
                     <label>Mot de passe</label>
                     <input type="password" class="form-control" placeholder="Mot de passe" name="password">
                  </div>
                  <button type="submit" class="btn btn-black">Se connecter</button>
                  <button class="btn btn-secondary" type="submit" formaction="inscription.jsp" >S'inscrire</button>
                <%
	    			String testlog = request.getParameter("log");
	                if (testlog != null && testlog != ""){
	                	out.println("<div style='color:red;margin-top:1em;'> Nom d'utilisateur et/ou mot de passe faux !</div>");
	                }
				%>	
               </form>
            </div>
         </div>
      </div>

</body>
</html>