import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places-upvote"
export default class extends Controller {
  static targets = ["count"]
  
  connect() {
    console.log("PlacesUpvoteController connected")
  }

  upvote(event) {
    event.preventDefault()
    fetch(this.upvoteUrl, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
      .then(response => response.json())
      .then(data => {
        this.countTarget.innerText = data.votes
        console.log("Upvote successful:", data.votes)
        console.log("Upvote URL:", this.upvoteUrl)
        const icon = this.element.querySelector("i.fa-thumbs-up")
        if (data.liked) {
          icon.classList.remove("fa-regular")
          icon.classList.add("fa-solid")
        } else {
          icon.classList.remove("fa-solid")
          icon.classList.add("fa-regular")
        }
      })
  }

  get upvoteUrl() {
    return this.element.querySelector("#upvote-link").href
  }

}
