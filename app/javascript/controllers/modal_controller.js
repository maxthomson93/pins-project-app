import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {}

  open(event) {
    event.preventDefault();
    console.log("MEOW");

    const modal = document.getElementById("search-modal");
    if (modal) {
      modal.classList.remove("hidden");
      modal.classList.add("show");

      // Add the backdrop dynamically
      const backdrop = document.createElement("div");
      backdrop.className = "modal-backdrop fade show";
      document.body.appendChild(backdrop);
    }
  }

  close() {
    const modal = document.getElementById("search-modal");
    if (modal) {
      modal.classList.remove("show");
      modal.classList.add("hidden");
    }

    // Remove the backdrop
    const backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
      backdrop.remove();
    }
  }
}
