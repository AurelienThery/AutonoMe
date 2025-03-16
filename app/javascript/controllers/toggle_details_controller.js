import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-details"
export default class extends Controller {

  static targets = ["togglableElement"]
  // static values = { activity: Object } // Permet de stocker et accéder à l'instance activity
  static values = { activityId: Number }
  connect() {
    console.log("Toggle details connected");
  }

  display(event) {
    event.preventDefault();
    this.togglableElementTarget.classList.toggle("d-none");
    console.log("Activity-ID:", this.activityIdValue);
  }
}
