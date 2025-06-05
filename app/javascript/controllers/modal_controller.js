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

  close(event) {
    event.preventDefault()
  const modal = bootstrap.Modal.getInstance(this.element);
  if (modal) modal.hide();
  }
}
