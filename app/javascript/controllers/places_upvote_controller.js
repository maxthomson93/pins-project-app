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
        data.votes = data.votes + 1
        this.countTarget.innerText = data.votes
        console.log("Upvote successful:", data.votes)
      })
  }

  get upvoteUrl() {
    return this.element.querySelector("#upvote-link").href
  }

}
