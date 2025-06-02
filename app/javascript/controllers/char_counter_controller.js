import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea", "count"]

  connect() {
    this.updateCount();
  }

  updateCount() {
    const length = this.textareaTarget.value.length;
    this.countTarget.textContent = `${length} / 300`;
  }

  onInput() {
    this.updateCount();
  }
}
