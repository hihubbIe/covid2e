<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/login.css"/>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<meta charset="ISO-8859-1">
<title>Accueil</title>
</head>
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
                  <div class="form-group">
                     <label>Nom d'utilisateur</label>
                     <input type="text" class="form-control" placeholder="username" name="name">
                  </div>
                  <div class="form-group">
                     <label>Mot de passe</label>
                     <input type="password" class="form-control" placeholder="password" name="password">
                  </div>
                  <button type="submit" class="btn btn-black">Se connecter</button>
                  <button type="submit" class="btn btn-secondary">S'inscrire</button>
               </form>
            </div>
         </div>
      </div>

</body>
</html>