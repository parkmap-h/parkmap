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
  $("#park_longitude").val(event.latLng.F)
  $("#park_latitude").val(event.latLng.A)

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
  lat = $("#park_latitude").val()
  long =  $("#park_longitude").val()
  position = new google.maps.LatLng(lat,long)
  mapOptions =
    zoom: 19
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
