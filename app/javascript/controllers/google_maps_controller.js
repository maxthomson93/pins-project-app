import { Controller } from "@hotwired/stimulus"
import GMaps from "gmaps"

// Connects to data-controller="google-maps"
export default class extends Controller {
  static targets = ["search", "map", "checkboxes", "pinsToggle"]
  static values = { markers: Array }

  connect() {
    this.initMap();
  }

  initMap() {
    const styles = this.#snazzyStyle;
    this.map = new GMaps({
      el: '#map',
      lat: 0,
      lng: 0,
      mapTypeControl: false,
      cameraControl: false,
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
    this.map.addMarkers(markers);
    this.reframe(markers);
  }

  reframe(markers = this.displayedMarkers) {
    if (!markers || markers.length === 0) {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;
            // Use lat and lng (e.g., center your map)
            this.map.setCenter(lat, lng);
            this.map.setZoom(14);
          },
          (error) => {
            // Handle error or fallback
            console.warn("Geolocation failed or denied:", error);
            this.map.setCenter(35.6895, 139.6917); // fallback to Tokyo
            this.map.setZoom(14);
          }
        );
      } else {
        // Geolocation not supported
        this.map.setCenter(35.6895, 139.6917);
        this.map.setZoom(14);
      }
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


  filterToggle(event) {
    // const checkedIndexes = this.checkboxesTargets.filter(cb => cb.checked).map(cb => parseInt(cb.dataset.mapIndex, 10) );
    event.currentTarget.classList.toggle("checked")
    const checkedIndexes = this.pinsToggleTargets.filter(pins => pins.classList.contains("checked") ).map(cb => parseInt(cb.dataset.mapIndex, 10) );
    const filteredMarkers = this.markers.filter(marker => checkedIndexes.includes(marker.map_index));

    this.showMarkers(filteredMarkers);
  }

  #snazzyStyle = [{
        "featureType": "all",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "weight": "2.00"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#9c9c9c"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "color": "#f2f2f2"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -100
            },
            {
                "lightness": 45
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#eeeeee"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#7b7b7b"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "color": "#46bcec"
            },
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#c8d7d4"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#070707"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    }];
}
