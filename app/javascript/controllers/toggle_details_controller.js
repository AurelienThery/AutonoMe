import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-details"
export default class extends Controller {

  static targets = ["togglableElement"]
  static values = { activityId: Number }
  connect() {
    console.log("Toggle details connected");
  }

  display(event) {
    event.preventDefault();
    console.log(this.togglableElementTarget)
    this.togglableElementTarget.classList.toggle("d-none");
    console.log("Activity-ID:", event.params.activityId);
  }
}
