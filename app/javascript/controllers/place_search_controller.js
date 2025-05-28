import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-search"
export default class extends Controller {
  static targets = ["search"]
  connect() {
    console.log("PlaceSearchController connected")
  }

  search(event) {
    event.preventDefault()
    const query = this.searchTarget.value.trim()
    if (query.length > 0) {
    fetch(`/places/search?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        // Handle the search results here
        console.log(data)
      })
      .catch(error => {
        console.error('Error fetching search results:', error)
      })
    }
  }
}
