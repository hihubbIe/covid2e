<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
	response.sendRedirect("index.jsp");
}
%>

<html>


<head>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="css/login.css" />
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<meta charset="ISO-8859-1">
<title>Lieu</title>
</head>

<%@include file="header_log.jsp"%>
<body>

	<section class="vh-100 bg-image" style="background-color: #6897BB;">
		<div class="mask d-flex align-items-center h-100 gradient-custom-3">
			<div class="container h-100">
				<div
					class="row d-flex justify-content-center align-items-center h-100">
					<div class="col-12 col-md-9 col-lg-7 col-xl-6">
						<div class="card" style="border-radius: 15px; margin-top: 5em;">
							<div class="card-body p-5">
								<h2 class="text-uppercase text-center mb-5">Création d'un
									lieu</h2>

								<%
								String testsuccess = request.getParameter("success");
								String testerreur = request.getParameter("echec");
								if (testsuccess != null && testsuccess != "") {
									out.println("<div style='color:green;'> Le lieu a été ajouté ! </div>");
								} else if (testerreur != null && testerreur != "") {
									out.println("<div style='color:red;'> Le lieu n'existe pas ! </div>");
								}
								%>

								<form action="AddLieu" method="post" class="">

									<div class="form-outline mb-4">
										<label class="form-label">Nom (Optionnel)</label> <input type="text"
											class="form-control form-control-lg" name="nom" />
									</div>

									<div class="form-outline mb-4">
										<label class="form-label">Numéro</label> <input type="number"
											class="form-control form-control-lg" name="numero" required />
									</div>

									<div class="form-outline mb-4">
										<label class="form-label">Rue</label> <input type="text"
											class="form-control form-control-lg" name="rue" required />
									</div>

									<div class="form-outline mb-4">
										<label class="form-label">Code Postal</label> <input
											type="text" class="form-control form-control-lg"
											name="postal" required />
									</div>

									<div class="form-outline mb-4">
										<label class="form-label">Ville</label> <input type="text"
											class="form-control form-control-lg" name="ville" required />
									</div>

									<div class="form-group">
										<label for="exampleFormControlSelect1">Pays</label> <select
											class="form-control" id="rien" name="pays">
											<%
											PaysDAO.getInstance();

											ArrayList<String> pays = new ArrayList<String>();

											pays = PaysDAO.getAllPays();

											for (int i = 0; i < pays.size(); i++) {
												out.println("<option>");
												out.println(pays.get(i));
												out.println("</option>");
											}
											%>
										</select>

									</div>

									<div class="d-flex justify-content-center">
										<button type="submit"
											class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Ajouter</button>
									</div>
									<br>
						
								</form>
								<form action="activite.jsp">
								
									<div class="d-flex justify-content-center">
										<button type="submit"
											class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Annuler</button>
									</div>
								
								</form>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>