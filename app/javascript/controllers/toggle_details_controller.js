import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-details"
export default class extends Controller {

  static targets = ["togglableElement"]
  static values = { activity: Object } // Permet de stocker et accéder à l'instance activity

  connect() {
    console.log("Toggle details connected");
  }

  display() {
    this.togglableElementTarget.classList.toggle("d-none");
    console.log(this.activityValue) // Pour vérifier qu'on récupère bien l'instance activity
  }
}
