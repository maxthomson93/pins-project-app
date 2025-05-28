import { Controller } from "@hotwired/stimulus"
import GMaps from "gmaps"

// Connects to data-controller="google-maps"
export default class extends Controller {
  connect() {
    console.log("google-maps#connect")
    this.map = new GMaps({
      el: this.element.querySelector("#map"),
      lat: 0,
      lng: 0
    })

    const markers = JSON.parse(this.element.dataset.markers)
    this.map.addMarkers(markers)

    if (markers.length === 0) {
      this.map.setZoom(2)
    } else if (markers.length === 1) {
      this.map.setCenter(markers[0].lat, markers[0].lng)
      this.map.setZoom(14)
    } else {
      this.map.fitLatLngBounds(markers)
    }
  }

  focusOn(event) {
    const lat = parseFloat(event.currentTarget.dataset.lat)
    const lng = parseFloat(event.currentTarget.dataset.lng)

    this.map.setCenter(lat, lng)
    this.map.setZoom(14)
  }
}
