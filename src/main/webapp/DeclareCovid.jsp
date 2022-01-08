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
<title>Insert title here</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/accueil.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
</head>

<%@ include file="header_log.jsp" %>
<div class="main-div2">
	<div class="container-sm css-container-profil">
		<div class="main-body">
			<form action="Positif" method="post">
				<input type='hidden' name="login" value='<% session.getAttribute("login"); %>'>
                  <button type="submit"  class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">J'AI LE COVIIIIIIIIID</button>
                
			</form>
		</div>
	</div>
</div>

</html>