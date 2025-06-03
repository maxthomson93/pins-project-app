import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["option", "input"]
  static values = { value: String }

  select(event) {
    const selectedValue = event.currentTarget.dataset.sharingValue;

    this.inputTarget.value = selectedValue;

    this.optionTargets.forEach(el => {
      el.classList.remove("btn-primary");
      el.classList.add("btn-outline-secondary");
    });

    event.currentTarget.classList.remove("btn-outline-secondary");
    event.currentTarget.classList.add("btn-primary");
  }
}
