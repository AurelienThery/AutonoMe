import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "confirmation", "message"]

  connect() {
    console.log("HelpCallsController connected")
  }

  togglePopup() {
    console.log("togglePopup called")
    this.popupTarget.classList.toggle("hidden")
  }

  handleOption(event) {
    console.log("handleOption called")
    const option = event.currentTarget.dataset.option
    let message = ""
    switch (option) {
      case "aller-aux-wc":
        message = "Demande à ton professeur."
        break
      case "trop-de-bruit":
        message = "Mets ton casque anti-bruit."
        break
      case "j-ai-une-question":
        message = "Pose la question à ton professeur."
        break
      default:
        message = "Option non reconnue."
    }
    this.messageTarget.textContent = message
    this.togglePopup()
    this.showConfirmation()
  }

  showConfirmation() {
    console.log("showConfirmation called")
    this.confirmationTarget.classList.remove("hidden")
  }

  confirmResolution() {
    console.log("confirmResolution called")
    alert("👍 Super ! Le problème est résolu.")
    this.confirmationTarget.classList.add("hidden")
  }

  reopenHelp() {
    console.log("reopenHelp called")
    this.confirmationTarget.classList.add("hidden")
    this.togglePopup()
  }
}
