import { Controller } from "@hotwired/stimulus"
import GMaps from "gmaps"

// Connects to data-controller="google-maps"
export default class extends Controller {
  static targets = ["search", "map", "checkboxes"]
  static values = { markers: Array }

  connect() {
    console.log("connected")
    this.map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    this.markers = JSON.parse(this.element.dataset.markers);
    console.log(this.markers)
    this.displayedMarkers = [];
    this.showMarkers(this.markers)
    // this.pins = this.map.addMarkers(this.markers);
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
        this.map.removeMarkers();
        this.map.addMarkers(data)
        this.reframe();
      })
      .catch(error => {
        console.error('Error fetching search results:', error)
      })
    }
  }

  showMarkers(markers) {
    this.map.removeMarkers();
    markers.forEach(marker => {
      if (marker.color) {
        marker.icon = `http://maps.google.com/mapfiles/ms/icons/${marker.color}-dot.png`;
      }
    })
    this.map.addMarkers(markers)
    this.reframe(markers);
  }

  reframe(markers = this.displayedMarkers) {
    if (!markers) markers = [];
    if (markers.length === 0) {
      this.map.setZoom(2);
    } else if (markers.length === 1) {
      this.map.setCenter(markers[0].lat, markers[0].lng);
      this.map.setZoom(14);
    } else {
      this.map.fitLatLngBounds(markers);
    }
  }


  focusOn(event) {
    const lat = parseFloat(event.currentTarget.dataset.lat)
    const lng = parseFloat(event.currentTarget.dataset.lng)

    this.map.setCenter(lat, lng)
    this.map.setZoom(20)
  }

  filterToggle() {
    const checkedIndexes = this.checkboxesTargets.filter(cb => cb.checked).map(cb => parseInt(cb.dataset.mapIndex, 10) );
    const filteredMarkers = this.markers.filter(marker => checkedIndexes.includes(marker.map_index));

    this.showMarkers(filteredMarkers);
  }
}
