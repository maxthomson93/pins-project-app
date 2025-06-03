// app/javascript/controllers/google_maps_controller.js

import { Controller } from "@hotwired/stimulus"
import GMaps from "gmaps"


export default class extends Controller {

  static values = { markers: Array }

  connect() {
    this.initMap()
  }

  initMap() {

    this.map = new GMaps({
      el: "#map",
      lat: 0,
      lng: 0,
      mapTypeControl: false,
      zoom: 14,
      fullscreenControl: false
    }); // Default to Tokyo coordinates
    this.markers = JSON.parse(this.element.dataset.markers);

    this.displayedMarkers = [];
    this.showMarkers(this.markers);
    // this.pins = this.map.addMarkers(this.markers);
    this.map.addStyle({
      styles: styles,
      mapTypeId: 'map_style'
    });
    this.map.setStyle('map_style');
  }


  search(event) {
    event.preventDefault()
    const query = this.searchTarget.value.trim()
    if (query.length > 0) {
    fetch(`/places/search?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        // Handle the search results here
        console.log(data);
        this.markers = data
        this.showMarkers(data);
      })
      .catch(error => {
        console.error('Error fetching search results:', error)
      })
    }
  }

  showMarkers(markers) {
    this.map.removeMarkers();
    this.map.addMarkers(markers);
    this.reframe(markers);
  }

  reframe(markersArray) {
    if (!markersArray || markersArray.length === 0) {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            this.map.setCenter(position.coords.latitude, position.coords.longitude)
            this.map.setZoom(14)
          },
          () => {

            this.map.setCenter(35.6895, 139.6917)
            this.map.setZoom(14)
          }
        )
      } else {
        this.map.setCenter(35.6895, 139.6917)
        this.map.setZoom(14)
      }
    } else if (markersArray.length === 1) {

      this.map.setCenter(markersArray[0].lat, markersArray[0].lng)
      this.map.setZoom(14)
    } else {

      this.map.fitLatLngBounds(markersArray)
    }
  }


  focusOn(event) {

    const lat = parseFloat(event.currentTarget.dataset.lat)
    const lng = parseFloat(event.currentTarget.dataset.lng)


    this.map.setCenter(lat, lng)
    this.map.setZoom(17)
  }
}
