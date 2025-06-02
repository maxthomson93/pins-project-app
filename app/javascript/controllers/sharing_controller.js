import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["option", "input"]

  select(event) {
    const selectedValue = event.currentTarget.dataset.value;

    this.inputTarget.value = selectedValue;

    this.optionTargets.forEach(el => {
      el.classList.remove("btn-primary");
      el.classList.add("btn-outline-secondary");
    });

    event.currentTarget.classList.remove("btn-outline-secondary");
    event.currentTarget.classList.add("btn-primary");
  }
}
