<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Erreur</title>


<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<link rel="stylesheet" href="css/accueil.css" />
</head>


<div class="main-div">

    <main role="main" class="container">
      <div class="starter-template">
        <h1>Page inexistante</h1>
        <br>
        <h3>La page que vous recherchez est inexistante !</h3>
      </div>
      
      <form action="index.jsp" class="mb-4">
      
         <div class="d-flex justify-content-center mb-4">
                  <button type="submit" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Retour</button>
                </div>
      
      </form>
                

    </main>
</div>
</html>