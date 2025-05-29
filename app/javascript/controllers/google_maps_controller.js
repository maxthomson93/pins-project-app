import { Controller } from "@hotwired/stimulus"
import GMaps from "gmaps"

// Connects to data-controller="google-maps"
export default class extends Controller {
  static targets = ["search", "map"]
  connect() {
    console.log("connected")
    this.map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    this.markers = JSON.parse(this.element.dataset.markers);
    console.log(this.markers)
    this.pins = this.map.addMarkers(this.markers);
    this.reframe();
  }

  search(event) {
    event.preventDefault()
    const query = this.searchTarget.value.trim()
    if (query.length > 0) {
    fetch(`/places/search?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        // Handle the search results here
        this.markers = data
        this.map.removeMarkers(this.pins);
        this.map.addMarkers(data)
        this.reframe();
      })
      .catch(error => {
        console.error('Error fetching search results:', error)
      })
    }
  }

  reframe() {
    if (this.markers.length === 0) {
      this.map.setZoom(2);
    } else if (this.markers.length === 1) {
      this.map.setCenter(this.markers[0].lat, this.markers[0].lng);
      this.map.setZoom(14);
    } else {
      this.map.fitLatLngBounds(this.markers);
    }
  }

  focusOn(event) {
    const lat = parseFloat(event.currentTarget.dataset.lat)
    const lng = parseFloat(event.currentTarget.dataset.lng)

    this.map.setCenter(lat, lng)
    this.map.setZoom(14)
  }
}
