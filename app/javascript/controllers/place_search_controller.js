import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-search"
export default class extends Controller {
  static targets = ["search"]
  connect() {
    console.log("PlaceSearchController connected")
  }

  search() {
    const query = this.searchTarget.value.trim()
    if (query.length > 0) {
    fetch(`/places/search?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(places => {
        console.log(places);
        // Handle the search results here
        const container = document.getElementById('places-cards');
        container.innerHTML = ""; // Clear previous results

        places.forEach(place => {
          const card = document.createElement('div');
          card.className = 'place-card';
          card.innerHTML = `
            <h3>${place.name}</h3>
            <p>${place.address}</p>
          `;
          container.appendChild(card);
        });
      })
      .catch(error => {
        console.error('Error fetching search results:', error)
      })
    }
  }
}
