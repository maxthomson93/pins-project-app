import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  open(event) {
    event.preventDefault()
    const modal = document.getElementById("search-modal")
    if (modal) {
      modal.classList.remove("hidden")
      modal.classList.add("show")
    }
  }

  static targets = ["modal"];

  close() {
    this.element.classList.add("hidden"); // Add the 'hidden' class to hide the modal
  }
}
