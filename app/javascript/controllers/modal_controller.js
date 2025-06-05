import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["modal"];

  connect() {
  }

  open(event) {
    event.preventDefault()
    console.log("MEOW");

    const modal = document.getElementById("search-modal")
    if (modal) {
      modal.classList.remove("hidden")
      modal.classList.add("show")
    }
  }

  close() {
    this.element.classList.add("hidden"); // Add the 'hidden' class to hide the modal
  }
}
