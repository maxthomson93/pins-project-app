import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-tags"
export default class extends Controller {
  connect() {
    console.log("connected")
    
  }

  toggle(event) {
    const tag = event.currentTarget.textContent.trim();
    this.addTag(tag);
    this.updateHiddenField();
  }

  addTag(tag) {
  const badgeContainer = document.querySelector('#selected-tags');
  if ([...badgeContainer.children].some(badge => badge.dataset.value === tag)) return;

    const badge = document.createElement("span");
    badge.className = "badge rounded-pill text-bg-primary text-white";
    badge.style.fontSize = "1em";
    badge.textContent = tag;
    badge.dataset.value = tag;
    badge.style.backgroundColor = "#52946B";
    badgeContainer.appendChild(badge);

    const deleteBtn = document.createElement("button");
    deleteBtn.type = "button";
    deleteBtn.className = "btn-close btn-close-white ms-2";
    deleteBtn.style.fontSize = "0.7em";
    badge.appendChild(deleteBtn);
    deleteBtn.addEventListener("click", (e) => {
      badge.remove();
      this.updateHiddenField();
    });
  }

  updateHiddenField() {
    const badgeContainer = document.querySelector('#selected-tags');
    const tags = [...badgeContainer.children].map(badge => badge.dataset.value);
    document.getElementById('map_tag_list').value = tags.join(',');
  }
}
