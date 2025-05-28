import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-map"
export default class extends Controller {
  static targets = ["map", "checkboxes"]

  connect() {
     this.mapTarget.addEventListener("google-maps:ready", (event) => {
      this.mapController = event.detail.controller;
      // Optionally, trigger an initial filter
      this.toggle();
    });
  }

  toggle() {
    if (!this.mapController) return;
    const checkedIndexes = this.checkboxesTargets.filter(cb => cb.checked).map(cb => parseInt(cb.dataset.mapIndex, 10) );
    const filteredMarkers = this.mapController.allMarkers.filter(marker => checkedIndexes.includes(marker.map_index));

    this.mapController.showMarkers(filteredMarkers);
  }
}
