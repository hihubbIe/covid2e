<%@page import="metier.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>C'est la carte</title>


<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
	

<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


<meta charset="utf-8">
<!-- Nous chargeons les fichiers CDN de Leaflet. Le CSS AVANT le JS -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" integrity="sha512-Rksm5RenBEKSKFjgI3a41vrjkw4EVPlJ3+OiI65vTjIdo9brlAacEuKOiQ5OFh7cOI1bkDwLqdLw3Zg0cRJAAQ==" crossorigin="" />
<style type="text/css">
    #map{ /* la carte DOIT avoir une hauteur sinon elle n'apparaît pas */
        height:400px;
    }
</style>


<%
if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
	response.sendRedirect("index.jsp");
}
%>

<%@include file="header_log.jsp" %>
<%@ page import="metier.User,util.UserDAO,java.util.ArrayList,java.util.Date,java.text.DateFormat,java.text.SimpleDateFormat" %>

<link rel="stylesheet" href="css/accueil.css" />
</head>


<div class="main-div">

    <main role="main" class="container">
      <div class="starter-template">
        <h1>Carte</h1>
        
            <div id="map">
	    <!-- Ici s'affichera la carte -->
			</div>
        
      </div>

    </main>
</div>
  <!-- Load Leaflet from CDN -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
    integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
    crossorigin=""/>
  <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
    integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
    crossorigin=""></script>

  <!-- Load Esri Leaflet from CDN -->
  <script src="https://unpkg.com/esri-leaflet@3.0.4/dist/esri-leaflet.js"
    integrity="sha512-oUArlxr7VpoY7f/dd3ZdUL7FGOvS79nXVVQhxlg6ij4Fhdc4QID43LUFRs7abwHNJ0EYWijiN5LP2ZRR2PY4hQ=="
    crossorigin=""></script>

  <!-- Load Esri Leaflet Geocoder from CDN -->
  <link rel="stylesheet" href="https://unpkg.com/esri-leaflet-geocoder@3.1.1/dist/esri-leaflet-geocoder.css"
    integrity="sha512-IM3Hs+feyi40yZhDH6kV8vQMg4Fh20s9OzInIIAc4nx7aMYMfo+IenRUekoYsHZqGkREUgx0VvlEsgm7nCDW9g=="
    crossorigin="">
  <script src="https://unpkg.com/esri-leaflet-geocoder@3.1.1/dist/esri-leaflet-geocoder.js"
    integrity="sha512-enHceDibjfw6LYtgWU03hke20nVTm+X5CRi9ity06lGQNtC9GkBNl/6LoER6XzSudGiXy++avi1EbIg9Ip4L1w=="
    crossorigin=""></script>
<div id="map" style="height: 200px"></div>

<script type="text/javascript">

           var lat = 48.6637568;
           var lon = 6.1734912;
           var macarte = null;
           
           var greenIcon = new L.Icon({
        	   iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
        	   shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        	   iconSize: [25, 41],
        	   iconAnchor: [12, 41],
        	   popupAnchor: [1, -34],
        	   shadowSize: [41, 41]
        	 });
           
           // Fonction d'initialisation de la carte
           function initMap() {
               // Créer l'objet "macarte" et l'insèrer dans l'élément HTML qui a l'ID "map"
               macarte = L.map('map').setView([lat, lon], 11);
               // Leaflet ne récupère pas les cartes (tiles) sur un serveur par défaut. Nous devons lui préciser où nous souhaitons les récupérer. Ici, openstreetmap.fr
               L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
                   // Il est toujours bien de laisser le lien vers la source des données
                   attribution: 'données © <a href="//osm.org/copyright">OpenStreetMap</a>/ODbL - rendu <a href="//openstreetmap.fr">OSM France</a>',
                   minZoom: 1,
                   maxZoom: 20
               }).addTo(macarte);
               
               <%
               
               // Toutes les activités :
            	   
            	   ActiviteDAO.getInstance();
               
               	   ArrayList<Activite> listAct = ActiviteDAO.getAllActivite();
               	   if (listAct != null && listAct.size()!=0){
	               	   for (int i=0; i<listAct.size(); i++){
	               		   	String coord = listAct.get(i).getAddress().getCoord();
	               		   	Activite act = listAct.get(i);
	               		   	
	             			DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm");
	               		   	
	               		   	String long_coord = coord.substring(0,coord.indexOf(","));
	               		   	String lat_coord = coord.substring(coord.indexOf(",")+1,coord.length());
	               		 	
	               		   	out.println("var marker"+i+" = L.marker(["+lat_coord+", "+long_coord+"],{icon:greenIcon}).addTo(macarte);");
	            		   
	               		   	String balise_string = "<a href=\"detailsActivite.jsp?id_activite="+act.getId()+"\"><h3>"+act.getName()+"</h3></a>";
	               		   	balise_string += "<div>"+act.getAddress().toString()+"</div>";
	               			balise_string += "<div> le "+formatter.format(act.getStart())+"</div>";
	               		   	
	               		   	out.println("marker"+i+".bindPopup('"+balise_string+"');");
	               		   	
	               		   	out.println("lat = "+lat_coord+"; long="+long_coord+";");
	               	   }
               	   }
               
               %>
               
               macarte.setView([lat, lon], 11);
               
               var searchControl = L.esri.Geocoding.geosearch({
            	    position: 'topright',
            	    placeholder: 'Entrez une adresse e.g "6 rue Jacques Callot"',
            	    useMapBounds: false,
            	    providers: [L.esri.Geocoding.arcgisOnlineProvider({
            	      apikey: "AAPKcffd8fc659604f51acb02c70170f9c33AleEtnu2HbY8eaYGkIC4k_crG-vm0eCOGO74ABqXiNJUXSd413O1Z8BenQb6GhwZ", // replace with your api key - https://developers.arcgis.com
            	      nearby: {
            	        lat: -33.8688,
            	        lng: 151.2093
            	      }
            	    })]
            	  }).addTo(macarte);

            	  var results = L.layerGroup().addTo(macarte);

            	  searchControl.on('results', function (data) {
            	    results.clearLayers();
            	    for (var i = data.results.length - 1; i >= 0; i--) {
            	      results.addLayer(L.marker(data.results[i].latlng));
            	    }
            	  });
                 
               
             
           }
           
           
           window.onload = function(){
			// Fonction d'initialisation qui s'exécute lorsque le DOM est chargé
			initMap(); 
           };
           
           
       </script>
        
</html>

