<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="GoChasquiAdmin.WebForm2" %>


<!DOCTYPE html>
<html>
<head>
	<title>Obtener ubicacion</title>
	 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB6XhmQ0TrlvdgfDu59q1lTyBp5NskGo7I&callback=initMap"></script>
</head>
<body>
	<h1>Obtener ubicacion y mostrarla en un mapa</h1>
<div id="map" style="width:100%;height:600px;"></div>

<script>
navigator.geolocation.getCurrentPosition(function(location) {
  console.log(location.coords.latitude);
  console.log(location.coords.longitude);

	var map;
	var center = {lat: location.coords.latitude, lng: location.coords.longitude};
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
		center: center,
		zoom: 11
		});

		var marker = new google.maps.Marker({
		position: {lat: location.coords.latitude, lng: location.coords.longitude},
		map:map,
		title: 'Ubication'

		});

	}
	initMap();
});
</script>


</body>
</html>