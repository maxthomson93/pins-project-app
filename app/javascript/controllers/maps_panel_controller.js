import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["collapsed"]

  toggle() {
    if (this.element.classList.contains(this.collapsedClass)) {
      this._expand();
    } else {
      this._collapse();
    }
  }

  _collapse() {
    this.element.classList.add(this.collapsedClass);
    this.element.classList.remove("is-expanded");
    this._rotateIcon(true);
  }

  _expand() {
    this.element.classList.remove(this.collapsedClass);
    this.element.classList.add("is-expanded");
    this._rotateIcon(false);
  }

  _rotateIcon(collapsed) {
    const icon = this.element.querySelector(".maps-panel__icon i");
    if (!icon) return;
    if (collapsed) {
      icon.classList.remove("fa-chevron-down");
      icon.classList.add("fa-chevron-up");
    } else {
      icon.classList.remove("fa-chevron-up");
      icon.classList.add("fa-chevron-down");
    }
  }
}
