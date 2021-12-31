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
<title>Activités</title>
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
								<h2 class="text-uppercase text-center mb-5">Ajouter Activité</h2>
								
								    
				                 <%
					    			String testsuccess = request.getParameter("success");
					                if (testsuccess != null && testsuccess != ""){
					                	out.println("<div style='color:green;'> Activité crée ! </div>");
					                }
								%>	

								<form action="AddActivite" method="post" class="">

									<div class="form-outline mb-4">
										<label class="form-label">Nom</label> <input type="text"
											class="form-control form-control-lg" name="nom" required/>
									</div>

									<div class="form-group">
										<label for="exampleFormControlSelect1">Lieu</label> <select
											class="form-control" id="rien" name="id_lieu">
											<%
											LieuDAO.getInstance();

											ArrayList<Lieu> lieux = new ArrayList<Lieu>();

											lieux = LieuDAO.getAllLieu();

											for (int i = 0; i < lieux.size(); i++) {
												Lieu lieu = lieux.get(i);
												out.println("<option value='"+lieu.getId()+"'>");
												out.println(lieu.getNum()+" "+lieu.getStreet()+" "+lieu.getZipcode()+" "+lieu.getCity());
												out.println("</option>");
											}
											%>
										</select>

									</div>
									
											    
					                 <%
						    			String testdate = request.getParameter("date");
						                if (testdate != null && testdate != ""){
						                	out.println("<div style='color:red;'> Les dates doivent être correctes ! </div>");
						                }
									%>	
										
									
									<div class="form-outline mb-4">
					                <label class="form-label">Début</label>
					                
					                 <input class="form-control form-control-lg" type="datetime-local" id="meeting-time"
									     name="debut" required>
									</div>
									
									<div class="form-outline mb-4">
					                <label class="form-label">Fin</label>
					                
					                 <input class="form-control form-control-lg" type="datetime-local" id="meeting-time"
									     name="fin" required>
									</div>
      

									<div class="d-flex justify-content-center">
										<button type="submit"
											class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Ajouter</button>
									</div>
									
								</form>
								<form class="mt-3" action="index.jsp">
								
									<div class="d-flex justify-content-center">
										<button type="submit" formaction="listActivite.jsp"
											class="btn btn-danger btn-block btn-lg gradient-custom-4 text-body">Annuler</button>
									</div>
								
								</form>
								<form class="mt-3" action="lieu.jsp">
								
								<div class="d-flex justify-content-center">
										<button type="submit" formaction="lieu.jsp"
											class="btn btn-info btn-block btn-lg gradient-custom-4 text-body">Ajouter un lieu</button>
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