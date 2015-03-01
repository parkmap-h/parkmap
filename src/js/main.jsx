"use strict";
var React = require('react');
var ReactGoogleMaps = require("react-googlemaps");
var GoogleMapsAPI = window.google.maps;
var jquery = require('jquery');

var Map = ReactGoogleMaps.Map;
var Marker = ReactGoogleMaps.Marker;

var baseurl = 'http://localhost:3000';
var production_host = 'parkmap.eiel.info';
if (location.hostname === production_host) {
    baseurl = 'http://' + production_host;
}

var Park = React.createClass({
  render: function() {
    return (<div className="park">
  <span>{this.props.name}</span>
  <span> {this.props.distance}</span>
  <br/>
  <img src={this.props.src} />
</div>);
  }
});

var Parkmap = React.createClass({
  getInitialState: function() {
    return {
      parks: [],
      target: new GoogleMapsAPI.LatLng(34.393056, 132.465511)
    };
  },

  handleSearch:  function() {
   var that = this;
   jquery.post(
     baseurl + '/.json',
     {distance: 300,longitude: this.state.target.D, latitude: this.state.target.k},
     function (data){
       that.setState({parks: data.features.sort(function(feature_a,feature_b) {
       var park_a = feature_a.properties;
       var park_b = feature_b.properties;
       return park_a.distance - park_b.distance;
})});
     }
   );
  },

  handleClick: function(e) {
    this.setState({target: e.latLng});
  },

  handleDrag: function(e) {
    this.setState({target: e.latLng});
  },

  render: function() {
    var parks = this.state.parks.map(function (feature) {
      var park = feature.properties;
      return <Park key={park.id} src={park.mini_photos[0]} name={park.name} distance={park.distance_human}/>;
    });
    var marks = this.state.parks.map(function (feature) {
      var coord = feature.geometry.coordinates;
      var park = feature.properties;
      return (
        <Marker key={park.id} position={new GoogleMapsAPI.LatLng(coord[1], coord[0])} />
      );});
    return <div>
<button onClick={this.handleSearch} className={"search-button"}> 検索 </button>
<Map
  initialZoom={17}
  initialCenter={this.state.target}
  width={'100%'}
  height={'100%'}
  onClick={this.handleClick}
>
   <Marker position={this.state.target} opacity={0.5} title={'目的地'} draggable={true} onDrag={this.handleDrag}/>
  {marks}
</Map>
<div className={"parks"}>
  {parks}
</div>
</div>;
  }
});

React.render(
  <Parkmap />,
 document.getElementById('map')
);
