import { Controller } from "@hotwired/stimulus"
// Don't forget to import GMaps!
// import GMaps from 'gmaps/gmaps.js';
import GMaps from "gmaps"
// Connects to data-controller="google-maps"
export default class extends Controller {
  static values = { markers: Array }

  connect() {
    this.map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    this.allMarkers = JSON.parse(this.element.dataset.markers);
    this.displayedMarkers = [];
    this.showMarkers(this.allMarkers);

    this.element.dispatchEvent(new CustomEvent("google-maps:ready", { detail: { controller: this } }));
  }

  showMarkers(markers) {
    this.map.removeMarkers();
    markers.forEach(marker => {
      if (marker.color) {
        marker.icon = `http://maps.google.com/mapfiles/ms/icons/${marker.color}-dot.png`;
      }
    })
    this.map.addMarkers(markers)

    if (markers.length === 0) {
      this.map.setZoom(2);
    } else if (markers.length === 1) {
      this.map.setCenter(markers[0].lat, markers[0].lng);
      this.map.setZoom(14);
    } else {
      this.map.fitLatLngBounds(markers);
    }
  }
}
