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
      const icon = this.iconTarget
      icon.classList.toggle("fa-bookmark")
      icon.classList.toggle("fa-thumbs-up")
    } else {
      console.error("Membership creation failed.")
    }
  }
}
