import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  async join(event) {
    event.preventDefault()

    const url = event.currentTarget.href

    const response = await fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
        "Content-Type": "application/json"
      },
    })

    if (response.ok) {
      const iconContainer = this.iconTarget
      iconContainer.innerHTML = '<i data-membership-target="icon" class="fa-solid fa-bookmark" style="color: #52946B; font-size: 1rem;"></i>'

    } else {
      console.error("Membership creation failed.")
    }
  }
}
