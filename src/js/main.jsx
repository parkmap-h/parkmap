"use strict";
var React = require('react/addons');
var ReactGoogleMaps = require("react-googlemaps");
var GoogleMapsAPI = window.google.maps;
var jquery = require('jquery');

var Map = ReactGoogleMaps.Map;
var Marker = ReactGoogleMaps.Marker;
var OverlayView = ReactGoogleMaps.OverlayView;

var baseurl = 'http://localhost:3000';
var production_host = 'parkmap.eiel.info';
if (location.hostname === production_host) {
  baseurl = 'http://' + production_host;
}

function date_format(date) {
  if (date == null) { return ""; };
  var date = new Date(date);
  return date.getHours() + "時" + date.getMinutes() + "分";
}

var ParkList = React.createClass({
  onClick: function(e) {
    this.props.onClick(this.props.number);
  },
  render: function() {
    var fee = "料金情報がありません。";
    if (this.props.fee) {
      fee = this.props.fee + "円かかります。";
    }
    return <div className="park-list" onClick={this.onClick}>
      <div className="header">
        <a href={"/parks/" + this.props.number + "/edit"}>
          <span className="number">{this.props.number}</span>
          <span className="name">{this.props.name}</span>
        </a>
        <span className="distance">{this.props.distance}</span>
      </div>
      <div className="body">
        <img src={this.props.src} />
        <span className="fee">{fee}</span>
      </div>
    </div>;
  }
});

var ParkShow = React.createClass({
  onMarkerClick: function(e) {
    this.props.onMarkerClick(this.props.number);
  },
  render: function() {
    var fee = "料金情報がありません。";
    if (this.props.fee) {
      fee = this.props.fee + "円かかります。";
    }
    return <div className="park-show">
      <div className="header">
        <a href={"/parks/" + this.props.number + "/edit"} target="_blank">
          <span className="number">{this.props.number}</span>
          <span className="name">{this.props.name}</span>
        </a>
        <span className="distance">{this.props.distance}</span>
      </div>
      <div className="body">
        <img src={this.props.src} />
        <span className="fee">{fee}</span>
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
      center: new GoogleMapsAPI.LatLng(34.393056, 132.465511),
      start_at: null,
      end_at: null
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
          }),
          marks: data.features.slice().sort(function(feature_a,feature_b) {
            var park_a = feature_a.properties;
            var park_b = feature_b.properties;
            var a = park_a.calc_fee;
            var b = park_b.calc_fee;
            if (a === null) { a = Number.POSITIVE_INFINITY; }
            if (b === null) { b = Number.POSITIVE_INFINITY; }
            return b - a;
          }),
          start_at: data.start_at,
          end_at: data.end_at
        }
      );
    };
    var data = {
      distance: 300,
      longitude: this.state.target.D,
      latitude: this.state.target.k,
      start_at: React.findDOMNode(this.refs.start_at).value,
      end_at: React.findDOMNode(this.refs.end_at).value
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
    this.setState({marks: this.state.marks.concat(parks)});
  },

  handleMarkClick: function(e) {
    var parks = this.state.parks.filter(
      function (park) { return park.properties.id == park_id; }
    );
    this.setState({marks: this.state.marks.concat(parks)});
  },

  onOverlayClick: function(park_id) {
    this.setState({focus_park: park_id});
  },

  handleDisplayList: function(e) {
    this.setState({is_display_list: true});
  },

  render: function() {
    var that = this;
    if (this.state.parks.length > 0) {
      var closeModal = function() {
        that.setState({is_display_list: false});
      };
      var parks = this.state.parks.map(function (feature) {
        var park = feature.properties;
        var onClick = function(e) {that.onOverlayClick(park);};
        return (
              <ParkList
               key={park.id}
               number={park.id}
               src={park.thumb_photos[0]}
               name={park.name}
               fee={park.calc_fee}
               distance={park.distance_human}
               onClick={onClick}
              />
          );
      });
      var list_view =(
          <div className="modal">
            <div className="close-modal" onClick={closeModal}/>
            <div className="modal-main">
              <div className="close"  onClick={closeModal}>閉じる</div>
              {parks}
              <div className="close"  onClick={closeModal}>閉じる</div>
            </div>
          </div>
      );

      var list_button = (
        <button className="list-button" onClick={this.handleDisplayList}>
          リストで見る
        </button>
      );
    }
    var overlays = this.state.marks.map(function (feature) {
      var coord = feature.geometry.coordinates;
      var park = feature.properties;
      var onclick =  function () {
        that.onOverlayClick(park);
      };
      return (
        <OverlayView
          key={"overlay-" + park.id}
          onClick={onclick}
          className="fee-overlay"
          mapPane="floatPane"
          position={new GoogleMapsAPI.LatLng(coord[1], coord[0])}
        >
          <h1>{park.calc_fee ? park.calc_fee + "円" : "情報なし"}</h1>
          <div className="pin"></div>
        </OverlayView>
      );
    });
    var modal = null;
    if (this.state.focus_park) {
      var closeModal = function() {
        that.setState({focus_park: null});
      };
      var focus = this.state.focus_park;
      modal = (<div className="modal" onClick={closeModal}>
                 <div className="close" onClick={closeModal}/>
                 <div className="modal-main">
                   <ParkShow
                    key={focus.id}
                    number={focus.id}
                    src={focus.mini_photos[0]}
                    name={focus.name}
                    fee={focus.calc_fee}
                    distance={focus.distance_human}
                   />
                 </div>
               </div>);
    }else {
      modal = null;
    }

    var message = "";
    if (this.state.start_at) {
        message = (
                <div className="message">
                  {date_format(this.state.start_at)}から{date_format(this.state.end_at)}の間を駐車した際の金額を表示しています
                </div>)
    }
    return <div>
      {list_button}
      <button className="location-button" onClick={this.handlePresentLocation}>        現在地
      </button>
      <button className="search-button" onClick={this.handleSearch}>
        検索
      </button>
      <input className="search-start" type="datetime-local" ref="start_at" />
      <input className="search-end" type="datetime-local" ref="end_at" />
      <Map
        initialZoom={16}
        center={this.state.center}
        onCenterChange={this.handleCenterChange}
        width={'100%'}
        height={'100%'}
        onClick={this.handleClick}
      >
        {message}
        <Marker position={this.state.target} title={'目的地'} draggable={true} onDrag={this.handleMarkerDrag}/>
        {overlays}
      </Map>
      {this.state.is_display_list ? list_view : null}
      {modal}
    </div>;
  }
});

React.render(
  <Parkmap />,
  document.getElementById('map')
);
