"use strict";
var React = require('react');
var ReactGoogleMaps = require("react-googlemaps");
var GoogleMapsAPI = window.google.maps;

var Map = ReactGoogleMaps.Map;

var Parkmap = React.createClass({
  render: function() {
    return <Map
       initialZoom={17}
       initialCenter={new GoogleMapsAPI.LatLng(34.393056, 132.465511)}
       width={'100%'}
       height={'100%'}
     />;
   }
});

var Hello = React.createClass({
  handleClick: function(event) {
      console.log('hoge');
  },
  render: function() {
    return <div onClick={hoge}>Hello, {this.props.name}!</div>;
  }
});

React.render(
  <Parkmap />,
 document.getElementById('map')
);
