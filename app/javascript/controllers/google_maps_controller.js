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
    })


    this.markers = JSON.parse(this.element.dataset.markers)


    this.showMarkers(this.markers)
  }

  showMarkers(markersArray) {

    this.map.removeMarkers()


    this.map.addMarkers(markersArray)


    this.reframe(markersArray)
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
