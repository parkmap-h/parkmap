"use strict";
var React = require('react/addons');
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
  onMarkerClick: function(e) {
    this.props.onMarkerClick(this.props.number);
  },
  render: function() {
    var fee = "料金情報がありません。";
    if (this.props.fee) {
      fee = "今から1時間停めると" + this.props.fee + "円かかります。";
    }
    return <div className="park">
      <div className="header">
        <a href={"/parks/" + this.props.number} + "/edit">
          <span className="number">{this.props.number}</span>
          <span className="name">{this.props.name}</span>
        </a>
        <span className="distance">{this.props.distance}</span>
      </div>
      <div className="body">
        <img src={this.props.src} />
        <span className="fee">{fee}</span>
        <button className="marker" onClick={this.onMarkerClick}>マーク</button>
      </div>
    </div>;
  }
});

var Parkmap = React.createClass({
  mixins: [React.addons.LinkedStateMixin],
  getInitialState: function() {
    return {
      marks: [],
      parks: [],
      target: new GoogleMapsAPI.LatLng(34.393056, 132.465511),
      center: new GoogleMapsAPI.LatLng(34.393056, 132.465511)
    };
  },

  handleSearch:  function() {
    ga('send', 'event', 'button', 'click', 'search');
    var that = this;
    var success = function (data){
      that.setState(
        {
          parks: data.features.sort(function(feature_a,feature_b) {
            var park_a = feature_a.properties;
            var park_b = feature_b.properties;
            return park_a.distance - park_b.distance;
          })
        }
      );
    };
    var data = {
      distance: 300,
      longitude: this.state.target.D,
      latitude: this.state.target.k
    };
    jquery.post(baseurl + '/.json',data,success);
  },

  handlePresentLocation: function(e) {
    var that = this;
    var success = function (e) {
      var latlng = new GoogleMapsAPI.LatLng(e.coords.latitude, e.coords.longitude);
      that.setState({center: latlng, target: latlng});
    };
    var error = function () {
      // TODO
    };
    navigator.geolocation.getCurrentPosition(success,error,{});
  },

  handleCenterChange: function(e) {
    this.setState({center: e.getCenter()});
  },

  handleClick: function(e) {
    this.setState({target: e.latLng});
  },

  handleMarkerDrag: function(e) {
    this.setState({target: e.latLng});
  },

  handleMarkerClick: function(park_id) {
    var parks = this.state.parks.filter(
      function (park) { return park.properties.id == park_id; }
    );
    console.log(park_id);
    this.setState({marks: this.state.marks.concat(parks)});
  },

  render: function() {
    var that = this;
    var parks = this.state.parks.map(function (feature) {
      var park = feature.properties;
      return <Park
        key={park.id}
        number={park.id}
        src={park.mini_photos[0]}
        name={park.name}
        fee={park.hour_fee}
        distance={park.distance_human}
        onMarkerClick={that.handleMarkerClick}
      />;
    });
    var marks = this.state.marks.map(function (feature) {
      var coord = feature.geometry.coordinates;
      var park = feature.properties;
      return (
        <Marker
          key={park.id}
          position={new GoogleMapsAPI.LatLng(coord[1], coord[0])}
          title={park.name}
        />
      );
    });
    if (marks.length == 0) {
      marks = (<p className="help">目的地を設定して検索をしてください。</p>);
    }
    return <div>
      <button className="location-button" onClick={this.handlePresentLocation}>
        現在地
      </button>
      <button className="search-button" onClick={this.handleSearch}>
        検索
      </button>
      <Map
        initialZoom={16}
        center={this.state.center}
        onCenterChange={this.handleCenterChange}
        width={'100%'}
        height={'100%'}
        onClick={this.handleClick}
        >
        <Marker position={this.state.target} opacity={0.5} title={'目的地'}    draggable={true} onDrag={this.handleMarkerDrag}/>
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
