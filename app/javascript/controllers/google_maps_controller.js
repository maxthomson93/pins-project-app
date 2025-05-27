import { Controller } from "@hotwired/stimulus"
// Don't forget to import GMaps!
// import GMaps from 'gmaps/gmaps.js';
import GMaps from "gmaps"
// Connects to data-controller="google-maps"
export default class extends Controller {
  connect() {
    console.log("connected")
    const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    const markers = JSON.parse(this.element.dataset.markers);
    console.log(markers)
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else {
      map.fitLatLngBounds(markers);
    }
  }
}
