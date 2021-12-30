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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<meta charset="ISO-8859-1">
<title>Inscription</title>
</head>

<%@include file="header_nolog.jsp" %>
<body>

<section class="vh-100 bg-image" style="background-color: #6897BB;">
  <div class="mask d-flex align-items-center h-100 gradient-custom-3">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
          <div class="card" style="border-radius: 15px;margin-top:5em;">
            <div class="card-body p-5">
              <h2 class="text-uppercase text-center mb-5">Création d'un compte</h2>

                <form action="Inscription" method="post" class="">
                
                 <%
	    			String testvide = request.getParameter("vide");
	                if (testvide != null && testvide != ""){
	                	out.println("<div style='color:red;'> Tous les champs sont obligatoires ! </div>");
	                }
				%>	
				
				  <%
	    			String testpseudo = request.getParameter("existe");
	                if (testpseudo != null && testpseudo != ""){
	                	out.println("<div style='color:red;'> Le pseudo existe déjà ! </div>");
	                }
				%>	
              
              
                <div class="form-outline mb-4">
                <label class="form-label">Pseudo</label>
                  <input type="text" class="form-control form-control-lg" name="pseudo"/>
                </div>

                <div class="form-outline mb-4">
                <label class="form-label">Nom</label>
                  <input type="text" class="form-control form-control-lg" name="nom" />
                </div>

                <div class="form-outline mb-4">
                 <label class="form-label">Prénom</label>
                  <input type="text" class="form-control form-control-lg" name="prenom" />
                </div>

                <div class="form-outline mb-4">
                <label class="form-label">Mot de passe</label>
                  <input type="password" class="form-control form-control-lg" name="mdp"/>
                </div>
                
                <div class="form-outline mb-4">
                <label class="form-label">Anniversaire</label>
                  <div class="input-append date md-form md-outline" id="dp3">
				    <input class="form-control form-control-lg" type="text" id="datepicker" placeholder="dd/mm/yyyy" name="anni"/> 
				       <span class="add-on"><i class="icon-calendar" id="cal2"></i></span>
				</div>
      
                </div>

                <div class="d-flex justify-content-center">
                  <button type="submit" class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">S'inscrire</button>
                </div>
                <br>
                <div class="d-flex justify-content-center">
                  <button type="submit" formaction="login.jsp"  class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Annuler</button>
                </div>
                

                <p class="text-center text-muted mt-5 mb-0">Votre compte existe déjà ? <a href="login.jsp" class="fw-bold text-body"><u>Se connecter</u></a></p>

              </form>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
</body>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" integrity="sha512-rxThY3LYIfYsVCWPCW9dB0k+e3RZB39f23ylUYTEuZMDrN/vRqLdaCBo/FbvVT6uC2r0ObfPzotsfKF9Qc5W5g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript">
jQuery.noConflict();
    $('#dp3').datepicker({
        weekStart: 1,
        format: 'dd/mm/yyyy',
        autoclose: true,
        todayHighlight: true,
        language: 'fr',
    });
    
</script>
</html>