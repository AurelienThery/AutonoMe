import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checklist"
export default class extends Controller {

  static targets = ["checkbox", "status"];

  connect() {
  }

  updateStatus(event) {
    const allChecked = this.checkboxTargets.every(checkbox => checkbox.checked);

    if (allChecked) {
      this.statusTarget.innerHTML = '<i class="fa-regular fa-square-check"></i>';
    } else {
      this.statusTarget.innerHTML = '<i class="fa-regular fa-rectangle-xmark"></i>';
    }
  }

  toggle(event) {
    console.log(event)
    this.updateStatus(); // Appelé à chaque changement
  }
}
