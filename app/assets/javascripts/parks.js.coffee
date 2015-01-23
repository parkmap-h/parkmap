# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = null
marker = null
parks = []

click = (event) ->
  if marker
    marker.setMap(null)

  marker = new google.maps.Marker
    position: event.latLng,
    draggable: false,
    map: map,
  $("#longitude").val(event.latLng.D)
  $("#latitude").val(event.latLng.k)

result = (event,data,status) ->
  for park in parks
    park.setMap(null)

  parks = []
  $parks = $("#parks")
  $parks.html("")
  for park in data
    parks << new google.maps.Marker
      position: new google.maps.LatLng(park.latitude, park.longitude)
      draggable: false,
      map: map
    $park = $('<li class="park"\>').append(park.name + " 距離" + park.distance)
    $parks.append($park)

initialize = ->
  position = new google.maps.LatLng(34.393056, 132.465511)
  mapOptions =
    zoom: 15
    center: position

  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  marker = new google.maps.Marker
    position: position
    draggable: false
    map: map
  google.maps.event.addListener(map, 'click', click)

google.maps.event.addDomListener(window, 'load', initialize)

$ ->
  $("#search").bind("ajax:success",result)
